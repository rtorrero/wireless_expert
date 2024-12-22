;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1) Plantilla (deftemplate)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate dispositivo-wifi
   "Plantilla para describir el estado de un dispositivo conectado a una red Wi-Fi."
   (slot id)                  ;; Identificador del dispositivo o escenario
   (slot ssid)                ;; Nombre de la red Wi-Fi
   (slot conectado (type SYMBOL))    ;; yes/no
   (slot intensidad (type INTEGER))  ;; Intensidad de señal (0-100)
   (slot banda (type SYMBOL))        ;; 2.4GHz o 5GHz
   (slot distancia (type INTEGER))   ;; Distancia aproximada al router (en metros)
   (slot interferencia (type SYMBOL));; baja, media, alta
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 2) Hechos (deffacts) - 5 instancias
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts estado-wifi
   "Cinco dispositivos/escenarios para diagnosticar."
   (dispositivo-wifi
      (id "Laptop Casa")
      (ssid "MiRedHogar")
      (conectado yes)
      (intensidad 75)
      (banda 2.4GHz)
      (distancia 5)
      (interferencia baja))

   (dispositivo-wifi
      (id "Movil Sala")
      (ssid "MiRedHogar")
      (conectado no)
      (intensidad 0)
      (banda 2.4GHz)
      (distancia 10)
      (interferencia media))

   (dispositivo-wifi
      (id "SmartTV")
      (ssid "MiRedHogar")
      (conectado yes)
      (intensidad 40)
      (banda 5GHz)
      (distancia 8)
      (interferencia alta))

   (dispositivo-wifi
      (id "Tablet")
      (ssid "MiRedHogar")
      (conectado yes)
      (intensidad 20)
      (banda 2.4GHz)
      (distancia 20)
      (interferencia alta))

   (dispositivo-wifi
      (id "PC Oficina")
      (ssid "OficinaWLAN")
      (conectado yes)
      (intensidad 60)
      (banda 5GHz)
      (distancia 7)
      (interferencia media))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 3) Variables globales (defglobal)
;;;    - Por ejemplo, el "umbral mínimo" de intensidad deseada
;;;      o un "umbral máximo" de distancia
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*umbral-intensidad* = 30)
(defglobal ?*umbral-distancia*  = 15)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4) Reglas (defrule) - 7 a 12 reglas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Regla 1: Dispositivos desconectados
(defrule dispositivo-desconectado
   (dispositivo-wifi (id ?id) (conectado no))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " NO está conectado." crlf
             " -> Verificar si la contraseña es correcta o si el router está encendido." crlf))

;;; Regla 2: Intensidad de señal muy baja
(defrule intensidad-baja
   (dispositivo-wifi (id ?id) 
                     (intensidad ?i&:(< ?i ?*umbral-intensidad*))
                     (conectado yes))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id " está conectado, pero la intensidad (" ?i
             ") es menor que el umbral (" ?*umbral-intensidad* ")." crlf
             " -> Recomendación: Acercar el router o utilizar un repetidor Wi-Fi." crlf))

;;; Regla 3: Distancia mayor al umbral
(defrule distancia-grande
   (dispositivo-wifi (id ?id) 
                     (distancia ?d&:(> ?d ?*umbral-distancia*))
                     (conectado yes))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id 
             " está demasiado lejos del router (" ?d "m)."
             crlf " -> Recomendación: Cambiar ubicación o instalar un repetidor." crlf))

;;; Regla 4: Interferencia alta
(defrule interferencia-alta
   (dispositivo-wifi (id ?id) (interferencia high|alta))
   =>
   (printout t "Diagnóstico: El dispositivo " ?id 
             " sufre interferencia alta." crlf
             " -> Recomendación: Cambiar canal Wi-Fi o reducir fuentes de interferencia (micros, paredes gruesas, etc.)." crlf))

;;; Regla 5: Recomendar banda 5GHz si la distancia es corta
(defrule sugerir-banda-5GHz
   (dispositivo-wifi (id ?id) (distancia ?d&:(< 10 ?d)) (banda 2.4GHz))
   =>
   (printout t "Recomendación: Si tu dispositivo " ?id 
             " está relativamente cerca (menos de 10m), prueba con la banda de 5GHz." crlf))

;;; Regla 6: Recomendar banda 2.4GHz si la distancia es grande
(defrule sugerir-banda-2.4GHz
   (dispositivo-wifi (id ?id) (distancia ?d&:(>= ?d 10)) (banda 5GHz))
   =>
   (printout t "Recomendación: El dispositivo " ?id 
             " está a " ?d "m. Quizá la banda de 2.4GHz sea más estable a larga distancia." crlf))

;;; Regla 7: Caso ideal (intensidad >= umbral y distancia <= umbral-distancia)
(defrule conexion-ideal
   (dispositivo-wifi (id ?id)
                     (intensidad ?i&:(>= ?i ?*umbral-intensidad*))
                     (distancia ?d&:(<= ?d ?*umbral-distancia*))
                     (conectado yes)
                     (interferencia baja|media))
   =>
   (printout t "El dispositivo " ?id " parece tener una conexión estable." crlf
             " -> Diagnóstico: No se detectan problemas evidentes." crlf))

;;; (Opcional) Regla 8: Mensaje final si algún dispositivo está desconectado
(defrule aviso-dispositivos-desconectados
   (dispositivo-wifi (conectado no))
   =>
   (printout t "Aviso: Se han detectado dispositivos desconectados. Verificar configuración." crlf))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 5) Ejecución
;;;    1. (load "tuarchivo.clp")
;;;    2. (reset)
;;;    3. (run)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
