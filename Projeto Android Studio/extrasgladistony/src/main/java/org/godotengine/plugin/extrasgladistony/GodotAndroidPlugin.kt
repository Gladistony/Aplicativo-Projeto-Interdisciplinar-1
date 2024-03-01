package org.godotengine.plugin.extrasgladistony

import android.Manifest
import android.R.attr.tag
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.icu.util.Calendar
import android.net.Uri
import android.os.Build
import android.util.Log
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.SignalInfo
import org.godotengine.godot.plugin.UsedByGodot
import java.io.File


class GodotAndroidPlugin(godot: Godot): GodotPlugin(godot) {
    override fun getPluginName() = "extrasgladistony"

    private val requestCodePermission = 10
    private val requiredPermission = mutableListOf(Manifest.permission.POST_NOTIFICATIONS).toTypedArray()
    private var notificationData = ""
    private var notificationTitle = ""
    private var notificationTime = 1
    private var notificationID = 1
    private var notificationButton1 = ""
    private var notificationButton2 = ""
    private var notificationModo = 1
    private var notificationPermissionAtivation = false
    private var notificationdia = 0
    private var notificationmes = 0
    private var notificationano = 0
    private var notificationrepetir = 0
    private var notificationHora = 0
    private var notificationMinuto = 0

    private var notificationIntroID = 0
    private var notificationIntroMetodo = 0

    @UsedByGodot
    private fun helloWorld() {
        runOnUiThread {
            Toast.makeText(activity, "Ola mundo", Toast.LENGTH_LONG).show()
            Log.v(pluginName, "Ola mundo")
        }
    }

    @UsedByGodot
    private fun avisosPrint(texto: String) {
        runOnUiThread {
            Toast.makeText(activity, texto, Toast.LENGTH_LONG).show()
            Log.v(pluginName, texto)
        }
    }

    @UsedByGodot
    private fun acionarNotificacao(texto: String, titulo: String, tempo:Int, idNot: Int){
        runOnUiThread{
            notificationData = texto
            notificationTitle = titulo
            notificationTime = tempo
            notificationID = idNot
            notificationModo = 1
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU){
                notificationPermissionAtivation = true
                requestPermission()
            } else {
                showNotification()
            }
        }
    }

    @UsedByGodot
    private fun adicionarNotificacaoDate(texto: String, titulo: String, idNot: Int, dia: Int, mes: Int, ano: Int, hora: Int, minuto: Int, repetir: Int){
        notificationData = texto
        notificationTitle = titulo
        notificationID = idNot
        notificationModo = 1
        notificationdia = dia
        notificationmes = mes
        notificationano = ano
        notificationrepetir = repetir
        notificationHora = hora
        notificationMinuto = minuto
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU){
            notificationPermissionAtivation = true
            requestPermission()
        } else {
            showNotification()
        }
    }

    @UsedByGodot
    private fun acionarNotificacaoBotao(texto: String, titulo: String, tempo:Int, idNot: Int, B1: String, B2:String){
        runOnUiThread{
            notificationData = texto
            notificationTitle = titulo
            notificationTime = tempo
            notificationID = idNot
            notificationModo = 3
            notificationButton1 = B1
            notificationButton2 = B2
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU){
                notificationPermissionAtivation = true
                requestPermission()
            } else {
                showNotificationData()
            }
        }
    }

    @UsedByGodot
    private fun cancelarNotificacao(idNot: Int){
        notificationData = ""
        notificationTitle = ""
        notificationID = idNot
        val am = activity!!.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val sender = getPendingIntent()
        am.cancel(sender)
    }

    @UsedByGodot
    private fun shareText(title: String?, subject: String?, text: String?) {
        val sharingIntent = Intent(Intent.ACTION_SEND)
        sharingIntent.setType("text/plain")
        sharingIntent.putExtra(Intent.EXTRA_SUBJECT, subject)
        sharingIntent.putExtra(Intent.EXTRA_TEXT, text)
        activity!!.startActivity(Intent.createChooser(sharingIntent, title))
    }

    @UsedByGodot
    private fun sharePic(path: String, title: String?, subject: String?, text: String?) {
        val f = File(path)
        val uri: Uri
        uri = try {
            FileProvider.getUriForFile(activity!!, activity!!.packageName, f)
        } catch (e: IllegalArgumentException) {
            return
        }
        val shareIntent = Intent(Intent.ACTION_SEND)
        shareIntent.setType("image/*")
        shareIntent.putExtra(Intent.EXTRA_SUBJECT, subject)
        shareIntent.putExtra(Intent.EXTRA_TEXT, text)
        shareIntent.putExtra(Intent.EXTRA_STREAM, uri)
        shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        activity!!.startActivity(Intent.createChooser(shareIntent, title))
    }

    override fun onGodotSetupCompleted() {
        super.onGodotSetupCompleted()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            val notificationChannel = NotificationChannel(
                activity?.packageName, "Lembretes de Medicamentos", NotificationManager.IMPORTANCE_DEFAULT
            )
            notificationChannel.description = "Lembra os horarios de medicamentos"

            val notificationManager =
                activity?.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(notificationChannel)
        }
    }

    private fun requestPermission(){
        activity?.let {
            ActivityCompat.requestPermissions(
                it,
                requiredPermission,
                requestCodePermission
            )
        }
    }

    override fun onMainRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>?,
        grantResults: IntArray?
    ) {
        super.onMainRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == requestCodePermission){
            if (allPermissionGranted()){
                if (notificationModo == 2){
                    showNotificationButton()
                } else if (notificationModo == 3){
                    showNotificationData()
                } else {
                    showNotification()
                }
            } else {
                Toast.makeText(activity, "Permissão Negada", Toast.LENGTH_LONG).show()
            }
        } else {
            if (notificationPermissionAtivation) {
                Toast.makeText(activity, "Permissão Negada", Toast.LENGTH_LONG).show()
            }
        }
        notificationPermissionAtivation = false
    }

    private fun allPermissionGranted() = requiredPermission.all{
        activity?.let {
                it1 -> ContextCompat.checkSelfPermission(
            it1, it
        )
        } == PackageManager.PERMISSION_GRANTED
    }

    private fun showNotificationButton(){
        val calendar: Calendar = Calendar.getInstance()
        calendar.setTimeInMillis(System.currentTimeMillis())
        calendar.add(Calendar.SECOND, notificationTime)
        val sender: PendingIntent = getPendingIntentButton(notificationButton1, notificationButton2)
        val am = activity!!.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        if(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
            am.setExact(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
        } else {
            am.set(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
        }
    }

    private fun showNotification(){
        val calendar: Calendar = Calendar.getInstance()
        calendar.setTimeInMillis(System.currentTimeMillis())
        calendar.add(Calendar.SECOND, notificationTime)
        val sender: PendingIntent = getPendingIntent()
        val am = activity!!.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        if(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
            am.setExact(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
        } else {
            am.set(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
        }
    }

    private fun showNotificationData(){
        val calendar: Calendar = Calendar.getInstance()
        calendar.setTimeInMillis(0)
        calendar.add(Calendar.HOUR, notificationHora)
        calendar.add(Calendar.MINUTE, notificationMinuto)
        calendar.add(Calendar.MONDAY, notificationmes)
        calendar.add(Calendar.DAY_OF_MONTH, notificationdia)
        calendar.add(Calendar.YEAR, notificationano)
        //calendar.set(notificationdia,notificationmes, notificationano,notificationHora,notificationMinuto)
        var repeat_duration: Int = notificationrepetir *3600;
        val sender: PendingIntent = getPendingIntent()
        val am = activity!!.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        if (repeat_duration == 0){
            if(android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                am.setExact(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
            } else {
                am.set(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), sender);
            }
        } else {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.KITKAT) {
                am.setRepeating(
                    AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(),
                    (repeat_duration * 1000).toLong(), sender
                );
            } else {
                am.setInexactRepeating(
                    AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(),
                    (repeat_duration * 1000).toLong(), sender
                );
            }
        }
    }

    private fun getPendingIntent(): PendingIntent {
        val i = Intent(
            activity!!.applicationContext,
            NotificacaoBroadcast::class.java
        )
        i.putExtra("Title", notificationTitle)
        i.putExtra("Data", notificationData)
        i.putExtra("Identidade", notificationID)
        return PendingIntent.getBroadcast(activity, tag, i, PendingIntent.FLAG_UPDATE_CURRENT)
    }

    private fun getPendingIntentButton(Nome1: String, Nome2:String): PendingIntent {
        val i = Intent(
            activity!!.applicationContext,
            NotificacaoButtonBroadcast::class.java
        )
        i.putExtra("Title", notificationTitle)
        i.putExtra("Data", notificationData)
        i.putExtra("Identidade", notificationID)
        i.putExtra("Botao1", Nome1)
        i.putExtra("Botao2", Nome2)
        return PendingIntent.getBroadcast(activity, tag, i, PendingIntent.FLAG_UPDATE_CURRENT)
    }
}