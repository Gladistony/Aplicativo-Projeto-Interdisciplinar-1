package org.godotengine.plugin.extrasgladistony


import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat


public class NotificacaoButtonBroadcast: BroadcastReceiver() {


    override fun onReceive(p0: Context?, p1: Intent) {
        var notificationData = p1.getStringExtra("Data")
        var notificationTitle = p1.getStringExtra("Title")
        var notificationID = p1.getIntExtra("Identidade",1)
        var notificaBotao1 = p1.getStringExtra("Botao1")
        var notificaBotao2 = p1.getStringExtra("Botao2")

        var appClass: Class<*>? = null
        appClass = try {
            Class.forName("com.godot.game.GodotApp")
        } catch (e: ClassNotFoundException) {
            // app not found, do nothing
            return
        }

        val intent2 = Intent(p0, appClass)
        intent2.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT or Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)


        val pendingIntent =
            PendingIntent.getActivity(p0, 0, intent2, PendingIntent.FLAG_UPDATE_CURRENT)
        val pendingButton1 = PendingIntent.getActivity(p0, 0, intent2, PendingIntent.FLAG_UPDATE_CURRENT)
        val pendingButton2 = PendingIntent.getActivity(p0, 0, intent2, PendingIntent.FLAG_UPDATE_CURRENT)

        val notificationManager =
            p0?.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val notification =
            NotificationCompat.Builder(p0!!, p0!!.packageName).setContentText(notificationData)
                .setContentTitle(notificationTitle)
                .setSmallIcon(R.drawable.ic_stat_name)
                .setContentIntent(pendingIntent)
                .addAction(0,notificaBotao1,pendingButton1)
                .addAction(0,notificaBotao2,pendingButton2)
                .setAutoCancel(true)
                .build()
        notificationManager.notify(notificationID, notification)
    }

}