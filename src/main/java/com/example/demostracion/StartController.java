package com.example.demostracion;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;

/**
 * URL de prueba
 * http://localhost:30400/demoping/start/ping
 */
@RestController
public class StartController {
    /**
     * La siguiente es la url a utilizar en ambiente de desarrollo
     * URL: http://localhost:30300/ejemploPing/start/ping
     * @return
     */
    @GetMapping(path = "/ping")
    public String pingGet(){
        java.util.Date fechaPing = new java.util.Date();
        String retorno = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        retorno = "Ping recibido el dia u hora: " + sdf.format(fechaPing) + "\n" +
                "Información agregada para probar la canalización CD+CI" + "\n" +
                "Favor de confirmar el cambio - texto agregado";
        return retorno;
    }

}
