package com.nebula.pidilite
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.provider.CallLog
import android.provider.Settings
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.nebula.pidilite/call"
    private val CHANNEL1 = "com.nebula.pidilite/permissions"

    // private lateinit var telephonyManager: TelephonyManager
    // private lateinit var phoneStateListener: MyPhoneStateListener
    private var isOutgoingCall: Boolean = false
    private var hasOutgoingCallBeenAnswered: Boolean = false

    private val CALL_PHONE_PERMISSION = 1
    private lateinit var telephonyManager: TelephonyManager
    private var startTime: Long = 0
    private val PERMISSION_REQUEST_CODE = 1001
    private val ALL_FILES_ACCESS_REQUEST_CODE = 1002 // ADD THIS NEW REQUEST CODE
    private var handler: Handler? = null
    private var checkForAnswerRunnable: Runnable? = null
    private var result: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        // REMOVE requestPermissions() from here. It will be called from Flutter via MethodChannel.
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "makeCall" -> {
                    val phoneNumber = call.argument<String>("number")
                    if (phoneNumber != null) {
                        makePhoneCall(phoneNumber)
                        result.success(null)
                    } else {
                        result.error("INVALID_INPUT", "Phone number not provided", null)
                    }
                }

                "startListening" -> {
                    startCallStateListener()
                    result.success("Listening for call state changes")
                }

                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL1
        ).setMethodCallHandler { call, result ->
            // Change the condition to explicitly handle "requestPermissions" from Flutter
            if (call.method == "requestCallLogPermission" || call.method == "requestPermissions") {
                this.result = result
                requestAllAppPermissions() // Call the new comprehensive permission function
            } else {
                result.notImplemented()
                // REMOVE redundant requestPermissions() here if it's not the explicit "requestPermissions" method
            }
        }
    }

    private fun makePhoneCall(phoneNumber: String) {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CALL_PHONE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.CALL_PHONE),
                CALL_PHONE_PERMISSION
            )
        } else {
            val intent = Intent(Intent.ACTION_CALL)
            intent.data = Uri.parse("tel:$phoneNumber")
            startActivity(intent)
            startCallStateListener()
        }
    }

    private fun startCallStateListener() {
        telephonyManager.listen(object : PhoneStateListener() {
            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
                super.onCallStateChanged(state, phoneNumber)
                when (state) {
                    TelephonyManager.CALL_STATE_RINGING -> {
                        Log.d("CALL_STATE", "Incoming call from $phoneNumber")
                        startTime = System.currentTimeMillis()
                        // sendCallStateToFlutter("Incoming", phoneNumber)
                    }

                    TelephonyManager.CALL_STATE_OFFHOOK -> {
//                        Log.d("CALL_STATE", "Call started")
//                        startTime = System.currentTimeMillis()
//                        sendCallStateToFlutter("Connected", phoneNumber)
                        if (!isOutgoingCall) {
                            // This block runs when the outgoing call is just placed
                            Log.d("CALL_STATE", "Outgoing call started")
                            //sendCallStateToFlutter("OutgoingCallStarted", phoneNumber)
                            isOutgoingCall = true
                            startTime = System.currentTimeMillis()
//                            handler = Handler(Looper.getMainLooper())
//                            checkForAnswerRunnable = Runnable {
//                                if (!hasOutgoingCallBeenAnswered) {
//                                    Log.d("CALL_STATE", "Outgoing call answered by the other party")
//                                    sendCallStateToFlutter("OutgoingCallAnswered", phoneNumber)
//                                    hasOutgoingCallBeenAnswered = true
//                                }
//                            }
//                            handler?.postDelayed(checkForAnswerRunnable!!, 3000)
//                        } else if (System.currentTimeMillis() - startTime > 3000) {
//                            // Call has been off-hook for more than 3 seconds, implying it's been answered
//                            if (!hasOutgoingCallBeenAnswered) {
//                                Log.d("CALL_STATE", "Outgoing call answered by the other party")
//                                sendCallStateToFlutter("OutgoingCallAnswered", phoneNumber)
//                                hasOutgoingCallBeenAnswered = true
                            // }
                        }
                    }

                    TelephonyManager.CALL_STATE_IDLE -> {
                        if (startTime > 0) {
                            val duration = (System.currentTimeMillis() - startTime) / 1000
                            Log.d("CALL_STATE", "Call ended. Duration: $duration seconds")
                            //sendCallStateToFlutter("Ended", phoneNumber, duration)
                            handler = Handler(Looper.getMainLooper())
                            checkForAnswerRunnable = Runnable {
                                // if (!hasOutgoingCallBeenAnswered) {
                                accessCallLogs()
                                // }
                            }
                            handler?.postDelayed(checkForAnswerRunnable!!, 3000)

                            startTime = 0
                        } else {
                            // accessCallLogs()
                            Log.d("CALL_STATE", "Call ended")
                            //sendCallStateToFlutter("Ended", phoneNumber)
                        }
                        isOutgoingCall = false
                        hasOutgoingCallBeenAnswered = false
                    }
                }
            }
        }, PhoneStateListener.LISTEN_CALL_STATE)
    }

    private fun sendCallStateToFlutter(
        state: String,
        phoneNumber: String?,
        duration: Long? = null,
        type: String?,
        date: String?
    ) {
        val arguments = if (duration != null) {
            mapOf(
                "state" to state,
                "number" to phoneNumber,
                "duration" to duration,
                "type" to type,
                "Date" to date
            )
        } else {
            mapOf("state" to state, "number" to phoneNumber, "type" to type, "Date" to date)
        }
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL).invokeMethod("callStateChanged", arguments)
        }
    }

    private fun accessCallLogs() {
        val cursor = contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            null, null, null, "${CallLog.Calls.DATE} DESC"
        )

        if (cursor != null && cursor.moveToFirst()) {
            val phoneNumber = cursor.getString(cursor.getColumnIndex(CallLog.Calls.NUMBER))
            val callDuration =
                cursor.getString(cursor.getColumnIndex(CallLog.Calls.DURATION)).toLong()
            val callDate = cursor.getString(cursor.getColumnIndex(CallLog.Calls.DATE))
            val TYPE = cursor.getString(cursor.getColumnIndex(CallLog.Calls.TYPE))
            Log.d(
                "CALL_LOG",
                "Phone Number: $phoneNumber, Duration: $callDuration seconds,$callDate"
            )
            sendCallStateToFlutter("Calllog", phoneNumber, callDuration, TYPE, callDate)
        }
        cursor?.close()
    }

    // RENAMED and MODIFIED the original requestPermissions functiona
    private fun requestAllAppPermissions() {
        val permissions = mutableListOf( // Use mutable list
            Manifest.permission.CALL_PHONE,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.READ_CALL_LOG,
            Manifest.permission.CAMERA,
            Manifest.permission.RECORD_AUDIO,
            Manifest.permission.ACCESS_FINE_LOCATION, // ADDED Location permission
            Manifest.permission.ACCESS_COARSE_LOCATION // ADDED Location permission
        )

        val permissionsToRequest = permissions.filter {
            ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED
        }.toMutableList() // Make it mutable

        var allFilesAccessGranted = true
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) { // Android 11 (API 30) and above
            if (!Environment.isExternalStorageManager()) {
                allFilesAccessGranted = false
                val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
                val uri = Uri.fromParts("package", packageName, null)
                intent.data = uri
                startActivityForResult(
                    intent,
                    ALL_FILES_ACCESS_REQUEST_CODE
                ) // Use startActivityForResult
                return // Exit here, will re-check after user returns from settings
            }
        } else { // For Android versions below 11, use READ_EXTERNAL_STORAGE and WRITE_EXTERNAL_STORAGE
            if (ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.READ_EXTERNAL_STORAGE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                permissionsToRequest.add(Manifest.permission.READ_EXTERNAL_STORAGE)
            }
            if (ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                permissionsToRequest.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
            }
        }


        if (permissionsToRequest.isNotEmpty()) {
            ActivityCompat.requestPermissions(
                this,
                permissionsToRequest.toTypedArray(),
                PERMISSION_REQUEST_CODE
            )
        } else if (allFilesAccessGranted) {
            // All runtime permissions are granted, and all files access (if applicable) is granted
            flutterEngine?.dartExecutor?.binaryMessenger?.let {
                MethodChannel(it, CHANNEL1).invokeMethod(
                    "permissionsResult",
                    "Granted"
                )
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults) // CALL SUPER HERE

        if (requestCode == PERMISSION_REQUEST_CODE) {
            val deniedPermissions = permissions.filterIndexed { index, _ ->
                grantResults[index] != PackageManager.PERMISSION_GRANTED
            }.toMutableList() // Make it mutable to add MANAGE_EXTERNAL_STORAGE if denied

            // Check MANAGE_EXTERNAL_STORAGE status again after runtime permissions are handled
            val isAllFilesAccessGranted = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                Environment.isExternalStorageManager()
            } else {
                ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.READ_EXTERNAL_STORAGE
                ) == PackageManager.PERMISSION_GRANTED &&
                        ContextCompat.checkSelfPermission(
                            this,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE
                        ) == PackageManager.PERMISSION_GRANTED
            }

            if (deniedPermissions.isEmpty() && isAllFilesAccessGranted) {
                flutterEngine?.dartExecutor?.binaryMessenger?.let {
                    MethodChannel(it, CHANNEL1).invokeMethod(
                        "permissionsResult",
                        "Granted"
                    )
                }
            } else {
                val allDenied = deniedPermissions.toMutableList()
                if (!isAllFilesAccessGranted && Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    allDenied.add("MANAGE_EXTERNAL_STORAGE") // Add a placeholder to indicate this was denied
                } else if (!isAllFilesAccessGranted && Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
                    // For < Android 11, add specific storage permissions if denied
                    if (ContextCompat.checkSelfPermission(
                            this,
                            Manifest.permission.READ_EXTERNAL_STORAGE
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        allDenied.add(Manifest.permission.READ_EXTERNAL_STORAGE)
                    }
                    if (ContextCompat.checkSelfPermission(
                            this,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        allDenied.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    }
                }

                flutterEngine?.dartExecutor?.binaryMessenger?.let {
                    MethodChannel(it, CHANNEL1).invokeMethod(
                        "permissionsResult",
                        "Denied: ${allDenied.joinToString(", ")}"
                    )
                }
            }
        }
    }

    // ADD THIS NEW FUNCTION TO HANDLE RESULT FROM ALL FILES ACCESS SETTINGS
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == ALL_FILES_ACCESS_REQUEST_CODE) {
            // After user returns from All Files Access settings, re-check all permissions
            requestAllAppPermissions()
        }
    }
}