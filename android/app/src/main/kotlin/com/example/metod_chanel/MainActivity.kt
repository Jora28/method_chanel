package com.example.metod_chanel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.BatteryManager
import android.os.Build
import android.provider.AlarmClock
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/battery"

    private fun getBatteryLevel(): Int {

        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
          batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
          val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
          batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
      }

      private fun sendEmailIntent(recipient:String?,subject:String?,message:String?) {
          val mIntent = Intent(Intent.ACTION_SEND)
       
        mIntent.data = Uri.parse("mailto:")
        mIntent.type = "text/plain"
          mIntent.putExtra(Intent.EXTRA_EMAIL, arrayOf(recipient))
          //put the Subject in the intent
          mIntent.putExtra(Intent.EXTRA_SUBJECT, subject)
          //put the message in the intent
          mIntent.putExtra(Intent.EXTRA_TEXT, message)
          try {
              //start email intent
              startActivity(Intent.createChooser(mIntent, "Choose Email Client..."))
          }
          catch (e: Exception){
              //if any thing goes wrong for example no email client application or any exception
              //get and show exception message
              Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
          }
      }

    private fun setAlarmClock(hour:Int?,minutes:Int?,alarmMessage:String?) {

        val intentAlarm = Intent(AlarmClock.ACTION_SET_ALARM)
        intentAlarm.putExtra(AlarmClock.EXTRA_HOUR,hour)
        intentAlarm.putExtra(AlarmClock.EXTRA_MINUTES,minutes)
        intentAlarm.putExtra(AlarmClock.EXTRA_MESSAGE,alarmMessage)
        if(intent.resolveActivity(packageManager)!=null){
            startActivity(intentAlarm)

        }else{
            Toast.makeText(this,"This app is not support this Acrion",Toast.LENGTH_SHORT).show()
        }



    }

      
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
        when (call.method) {
            "getBatteryLevel" ->{
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }
            "setAlarm" -> {
                var hour  = call.argument<Int>("hour")
                var minutes = call.argument<Int>("minute")
                var alarmMessage = call.argument<String>("title")
                val setAlarmIntent = setAlarmClock(hour = hour,minutes = minutes,alarmMessage = alarmMessage)
                result.success(setAlarmIntent)
            }
            "sendEmail" -> {
                var recipient = call.argument<String>("recipient")
                var subject  = call.argument<String>("subject")
                var message = call.argument<String>("message")

                val intent = sendEmailIntent(recipient = recipient,subject = subject,message = message)
                result.success(intent)
            }

            else->{
                result.notImplemented()
            }
        }
//       if (call.method == "getBatteryLevel") {
//         val batteryLevel = getBatteryLevel()
//
//         if (batteryLevel != -1) {
//           result.success(batteryLevel)
//         } else {
//           result.error("UNAVAILABLE", "Battery level not available.", null)
//         }
//       } else
//        if (call.method == "setAlarm"){
//            var hour  = call.argument<Int>("hour")
//            var minutes = call.argument<Int>("minute")
//            var alarmMessage = call.argument<String>("title")
//            val setAlarmIntent = setAlarmClock(hour = hour,minutes = minutes,alarmMessage = alarmMessage)
//            result.success(setAlarmIntent)
//        }
//        else
//         if(call.method == "sendEmail"){
//             var recipient = call.argument<String>("recipient")
//             var subject  = call.argument<String>("subject")
//             var message = call.argument<String>("message")
//
//             val intent = sendEmailIntent(recipient = recipient,subject = subject,message = message)
//             result.success(intent)
//         }
//
    }
  }
}
