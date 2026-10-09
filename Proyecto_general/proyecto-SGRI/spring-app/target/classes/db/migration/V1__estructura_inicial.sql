-- 1
DROP TABLE IF EXISTS `cargo`;

CREATE TABLE `cargo` (
  `id_cargo` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del cargo.',
  `codigo` varchar(30) NOT NULL COMMENT 'Código interno del cargo.',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del cargo.',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción del cargo.',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el cargo se encuentra activo.',
  PRIMARY KEY (`id_cargo`),
  UNIQUE KEY `uk_cargo_codigo` (`codigo`),
  UNIQUE KEY `uk_cargo_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 2
DROP TABLE IF EXISTS `estado_aprobacion`;

CREATE TABLE `estado_aprobacion` (
  `id_estado_aprobacion` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de estados de aprobación.',
  `nombre_estado` varchar(50) NOT NULL COMMENT 'Nombre legible para mostrar en la interfaz de usuario (Ej: Pendiente de Revisión, Aprobado, Rechazado).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por los desarrolladores para mapeo en los Enum de Java (Ej: PENDIENTE, APROBADO, RECHAZADO).',
  `es_final` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Bandera lógica de control de flujo. TRUE/1 indica que la solicitud fue resuelta definitivamente; FALSE/0 significa que sigue en evaluación.',
  PRIMARY KEY (`id_estado_aprobacion`),
  UNIQUE KEY `uq_estado_aprobacion_nombre` (`nombre_estado`),
  UNIQUE KEY `uq_estado_aprobacion_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 3
DROP TABLE IF EXISTS `estado_incidencia`;

CREATE TABLE `estado_incidencia` (
  `id_estado_incidencia` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de estados de incidencias.',
  `nombre_estado` varchar(50) NOT NULL COMMENT 'Nombre legible para mostrar en la interfaz de usuario (Ej: Abierta, Asignada, En Proceso, Resuelta, Cerrada).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas para mapeo rígido en los Enum del código Java (Ej: ABIERTA, EN_PROCESO, CERRADA).',
  `es_final` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Bandera lógica de control de flujo. TRUE/1 indica que el ticket alcanzó una etapa de cierre definitivo; FALSE/0 indica que sigue operativo.',
  PRIMARY KEY (`id_estado_incidencia`),
  UNIQUE KEY `uq_estado_incidencia_nombre` (`nombre_estado`),
  UNIQUE KEY `uq_estado_incidencia_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 4
DROP TABLE IF EXISTS `estado_recurso`;

CREATE TABLE `estado_recurso` (
  `id_estado_recurso` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de estados de recursos.',
  `nombre_estado` varchar(50) NOT NULL COMMENT 'Nombre amigable y legible para mostrar en la interfaz de usuario (Ej: Disponible, En Mantenimiento, Baja Definitiva).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por los desarrolladores en el código Java / Enum para la lógica de negocio (Ej: DISPONIBLE, EN_REPARACION).',
  PRIMARY KEY (`id_estado_recurso`),
  UNIQUE KEY `uq_estado_recurso_nombre` (`nombre_estado`),
  UNIQUE KEY `uq_estado_recurso_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 5
DROP TABLE IF EXISTS `estado_reserva`;

CREATE TABLE `estado_reserva` (
  `id_estado_reserva` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de estados de reservas.',
  `nombre_estado` varchar(50) NOT NULL COMMENT 'Nombre legible para mostrar en la interfaz de usuario (Ej: Pendiente de Aprobación, Confirmada, Cancelada, Expirada).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por los desarrolladores para mapeo directo en los Enum de Java (Ej: PENDIENTE, CONFIRMADA, RECHAZADA, EXPIRADA).',
  `es_final` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Bandera lógica de control de flujo. TRUE/1 indica que la reserva alcanzó un estado de cierre inmutable; FALSE/0 significa que sigue activa o en transición.',
  PRIMARY KEY (`id_estado_reserva`),
  UNIQUE KEY `uq_estado_reserva_nombre` (`nombre_estado`),
  UNIQUE KEY `uq_estado_reserva_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 6
DROP TABLE IF EXISTS `parametro_global`;

CREATE TABLE `parametro_global` (
  `id_parametro` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del parámetro global.',
  `codigo` varchar(100) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por los desarrolladores para invocar la propiedad en el código Java (Ej: MAX_ALERTAS_DIARIAS, EMAIL_SOPORTE).',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre descriptivo amigable para mostrar en la interfaz de administración (Ej: Correo de Notificaciones de Soporte).',
  `valor` varchar(500) NOT NULL COMMENT 'Valor del parámetro global almacenado como texto. Su interpretación depende del tipo_dato definido para el parámetro.',
  `tipo_dato` enum('STRING','INTEGER','BOOLEAN','DECIMAL','DATE','EMAIL') NOT NULL DEFAULT 'STRING' COMMENT 'Define el tipo de dato esperado para el valor del parámetro y permite al backend y al panel de administración aplicar validaciones.',
  `editable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el parámetro puede ser modificado desde el panel de administración. FALSE para parámetros protegidos del sistema.',
  PRIMARY KEY (`id_parametro`),
  UNIQUE KEY `uq_parametro_global_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 7
DROP TABLE IF EXISTS `politica_prestamo`;

CREATE TABLE `politica_prestamo` (
  `id_politica` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de la política de préstamo.',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre descriptivo de la política de asignación (Ej: Reserva Express, Préstamo de Alta Jerarquía, Equipos Comunes).',
  `max_duracion_minutos` int unsigned NOT NULL COMMENT 'Tiempo máximo permitido para el uso consecutivo del recurso en una sola reserva (Ej: 120 = 2 horas).',
  `max_recursos_prestamo` int unsigned NOT NULL DEFAULT '1' COMMENT 'Cantidad máxima de unidades de este tipo de recurso que el solicitante puede incluir en una misma reserva.',
  `max_dias_anticipacion` int unsigned NOT NULL DEFAULT '30' COMMENT 'Gobernanza de agenda. Define con cuántos días de anticipación como máximo se puede apartar el recurso en el calendario.',
  PRIMARY KEY (`id_politica`),
  UNIQUE KEY `uq_politica_prestamo_nombre` (`nombre`),
  CONSTRAINT `chk_politica_prestamo_anticipacion_valida` CHECK ((`max_dias_anticipacion` > 0)),
  CONSTRAINT `chk_politica_prestamo_duracion_positiva` CHECK ((`max_duracion_minutos` > 0)),
  CONSTRAINT `chk_politica_prestamo_recursos_positivos` CHECK ((`max_recursos_prestamo` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 8
DROP TABLE IF EXISTS `prioridad`;

CREATE TABLE `prioridad` (
  `id_prioridad` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de prioridades.',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre legible para mostrar en la interfaz de usuario (Ej: Baja, Media, Alta, Crítica / Emergencia).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por los desarrolladores para la lógica en los Enum de Java (Ej: BAJA, MEDIA, CRITICA).',
  `nivel` tinyint unsigned NOT NULL COMMENT 'Peso numérico de criticidad utilizado para ordenar algoritmos de atención (Ej: 1 = Menor urgencia, 5 = Máxima urgencia).',
  PRIMARY KEY (`id_prioridad`),
  UNIQUE KEY `uq_prioridad_nombre` (`nombre`),
  UNIQUE KEY `uq_prioridad_codigo` (`codigo`),
  UNIQUE KEY `uq_prioridad_nivel` (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 9
DROP TABLE IF EXISTS `rol`;

CREATE TABLE `rol` (
  `id_rol` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de roles del sistema.',
  `nombre_rol` varchar(50) NOT NULL COMMENT 'Nombre descriptivo legible para mostrar en la interfaz (Ej: Solicitante Estándar, Agente de Soporte, Administrador).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas utilizada por Spring Security para el control de endpoints y mapeo de ENUM en Java (Ej: SOLICITANTE, AGENTE, ADMIN).',
  `limite_reservas_activas` int unsigned NOT NULL DEFAULT '3' COMMENT 'Gobernanza centralizada de inventario basada en el rol institucional. Define el máximo de reservas controladas simultáneas permitidas para este perfil.',
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `uq_rol_nombre` (`nombre_rol`),
  UNIQUE KEY `uq_rol_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 10
DROP TABLE IF EXISTS `tipo_incidencia`;

CREATE TABLE `tipo_incidencia` (
  `id_tipo_incidencia` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de tipos de incidencias.',
  `nombre_tipo` varchar(100) NOT NULL COMMENT 'Nombre legible para mostrar en la interfaz de usuario (Ej: Falla de Hardware, Error de Red, Mantenimiento Locativo).',
  `codigo` varchar(20) NOT NULL COMMENT 'Clave alfanumérica fija en mayúsculas para el mapeo rígido y seguro en los Enum del código Java (Ej: HARDWARE, SOFTWARE, RED).',
  PRIMARY KEY (`id_tipo_incidencia`),
  UNIQUE KEY `uq_tipo_incidencia_nombre` (`nombre_tipo`),
  UNIQUE KEY `uq_tipo_incidencia_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 11
DROP TABLE IF EXISTS `tipo_intervencion`;

CREATE TABLE `tipo_intervencion` (
  `id_tipo_intervencion` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria del catálogo de tipos de intervención técnica.',
  `codigo` varchar(20) NOT NULL COMMENT 'Código corto y único del tipo de intervención.',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre del tipo de intervención técnica.',
  `descripcion` varchar(200) DEFAULT NULL COMMENT 'Descripción del propósito o uso del tipo de intervención.',
  PRIMARY KEY (`id_tipo_intervencion`),
  UNIQUE KEY `uq_tipo_intervencion_codigo` (`codigo`),
  UNIQUE KEY `uq_tipo_intervencion_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 12
DROP TABLE IF EXISTS `tipo_recurso`;

CREATE TABLE `tipo_recurso` (
  `id_tipo_recurso` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del catálogo de tipos de recursos.',
  `nombre_tipo` varchar(50) NOT NULL COMMENT 'Nombre descriptivo de la categoría o tipo de activo (Ej: Aula Virtual, Laptop, Proyector).',
  `codigo` varchar(50) NOT NULL COMMENT 'Código técnico alfanumérico, único e inmutable usado para reglas de negocio en el backend y evitar dependencia de IDs o nombres comerciales (Ej: LAPTOP, AULA).',
  PRIMARY KEY (`id_tipo_recurso`),
  UNIQUE KEY `uq_tipo_recurso_nombre` (`nombre_tipo`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 13
DROP TABLE IF EXISTS `departamento`;

CREATE TABLE `departamento` (
  `id_departamento` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del departamento.',
  `codigo` varchar(20) NOT NULL COMMENT 'Código institucional del departamento.',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del departamento.',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción opcional del departamento.',
  `responsable_usuario_id` bigint unsigned DEFAULT NULL COMMENT 'Usuario responsable del departamento.',
  `email_contacto` varchar(120) DEFAULT NULL COMMENT 'Correo electrónico del departamento.',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el departamento está activo.',
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `uk_departamento_codigo` (`codigo`),
  UNIQUE KEY `uk_departamento_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 14
DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `id_usuario` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del usuario.',
  `email` varchar(100) NOT NULL COMMENT 'Correo electrónico institucional. Actúa como nombre de usuario único para el inicio de sesión.',
  `password_hash` char(60) NOT NULL COMMENT 'Contraseña del usuario encriptada mediante algoritmo BCrypt (longitud fija de 60 caracteres por Spring Security).',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de pila del usuario o empleado.',
  `apellidos` varchar(100) NOT NULL COMMENT 'Apellidos del usuario o empleado.',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Número telefónico de contacto directo para comunicaciones urgentes sobre recursos o incidencias.',
  `habilitado` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Interruptor de estado lógico de seguridad. TRUE/1 = Usuario activo con acceso al sistema; FALSE/0 = Cuenta suspendida o inactiva.',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora en que se creó el usuario dentro del sistema SGRI.',
  `departamento_id` bigint unsigned DEFAULT NULL COMMENT 'Departamento al que pertenece el usuario.',
  `cargo_id` bigint unsigned DEFAULT NULL COMMENT 'Cargo institucional del usuario.',
  `fecha_actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última modificación del usuario.',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `uq_usuario_email` (`email`),
  KEY `idx_usuario_departamento` (`departamento_id`),
  KEY `idx_usuario_cargo` (`cargo_id`),
  KEY `idx_usuario_departamento_habilitado` (`departamento_id`,`habilitado`),
  CONSTRAINT `fk_usuario_cargo` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id_cargo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id_departamento`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 15
DROP TABLE IF EXISTS `usuario_rol`;

CREATE TABLE `usuario_rol` (
  `id_usuario` bigint unsigned NOT NULL COMMENT 'Llave primaria compuesta (Parte 1). Enlace foráneo directo hacia la cuenta de usuario base.',
  `id_rol` int unsigned NOT NULL COMMENT 'Llave primaria compuesta (Parte 2). Enlace foráneo directo hacia el rol institucional asignado.',
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `idx_usuario_rol_rol` (`id_rol`),
  CONSTRAINT `fk_usuario_rol_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_rol_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 16
DROP TABLE IF EXISTS `recurso`;

CREATE TABLE `recurso` (
  `id_recurso` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada recurso físico en el inventario.',
  `id_tipo_recurso` int unsigned NOT NULL COMMENT 'Enlace al catálogo que define el tipo o categoría de activo (Ej: Laptop, Aula 302).',
  `id_politica` int unsigned NOT NULL COMMENT 'Vínculo a la política de préstamo y gobernanza que rige sobre este recurso.',
  `id_estado_recurso` int unsigned NOT NULL DEFAULT '1' COMMENT 'Enlace al catálogo maestro de estados operativos (Ej: 1 = Disponible, 2 = En Mantenimiento, 3 = Baja Definitiva).',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre descriptivo comercial o común del recurso (Ej: Proyector Epson 4K X1).',
  `codigo_inv` varchar(50) NOT NULL COMMENT 'Código único o número de placa de inventario físico asignado para el control de activos.',
  `ubicacion` varchar(100) DEFAULT NULL COMMENT 'Ubicación física base del recurso dentro de las instalaciones (Ej: Almacén Central, Aula 102, Oficina 4).',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora en que el recurso fue dado de alta en el inventario del sistema.',
  PRIMARY KEY (`id_recurso`),
  UNIQUE KEY `uq_recurso_codigo_inv` (`codigo_inv`),
  KEY `idx_recurso_tipo` (`id_tipo_recurso`),
  KEY `idx_recurso_politica` (`id_politica`),
  KEY `idx_recurso_estado` (`id_estado_recurso`),
  CONSTRAINT `fk_recurso_estado` FOREIGN KEY (`id_estado_recurso`) REFERENCES `estado_recurso` (`id_estado_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recurso_politica` FOREIGN KEY (`id_politica`) REFERENCES `politica_prestamo` (`id_politica`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recurso_tipo` FOREIGN KEY (`id_tipo_recurso`) REFERENCES `tipo_recurso` (`id_tipo_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 17
DROP TABLE IF EXISTS `horario_recurso`;

CREATE TABLE `horario_recurso` (
  `id_horario` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de la franja horaria de disponibilidad.',
  `recurso_id` bigint unsigned NOT NULL COMMENT 'ID del recurso físico al que se le parametriza la ventana de disponibilidad operativa.',
  `dia_semana` tinyint unsigned NOT NULL COMMENT 'Gobernanza del calendario semanal. Representa numéricamente el día (Ej: 1 = Lunes, 2 = Martes, ..., 7 = Domingo).',
  `hora_inicio` time NOT NULL COMMENT 'Momento exacto en el que el recurso entra en estado hábil para ser solicitado (Ej: 08:00:00).',
  `hora_fin` time NOT NULL COMMENT 'Momento exacto en el que concluye la ventana de disponibilidad para el préstamo (Ej: 14:00:00).',
  PRIMARY KEY (`id_horario`),
  KEY `idx_horario_recurso_dia` (`recurso_id`,`dia_semana`),
  CONSTRAINT `fk_horario_recurso_recurso` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id_recurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_horario_dia_semana_valido` CHECK ((`dia_semana` between 1 and 7)),
  CONSTRAINT `chk_horario_secuencia_horas` CHECK ((`hora_fin` > `hora_inicio`))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 18
DROP TABLE IF EXISTS `reserva`;

CREATE TABLE `reserva` (
  `id_reserva` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de la solicitud de reserva.',
  `solicitante_id` bigint unsigned NOT NULL COMMENT 'ID del usuario que genera y se responsabiliza de la solicitud de préstamo.',
  `estado_reserva_id` int unsigned NOT NULL COMMENT 'Enlace al catálogo maestro de estados de reserva (Ej: Pendiente, Confirmada, Cancelada, Expirada).',
  `fecha_inicio` datetime NOT NULL COMMENT 'Fecha y hora exacta programada para el inicio del préstamo y bloqueo del recurso.',
  `fecha_fin` datetime NOT NULL COMMENT 'Fecha y hora exacta pactada para la devolución del recurso y liberación de la agenda.',
  `motivo_anulacion` text COMMENT 'Texto explicativo obligatorio o aclaratorio detallado en caso de que la reserva sea cancelada o rechazada.',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Sello de tiempo automático que registra el microsegundo exacto en el que se creó la solicitud.',
  PRIMARY KEY (`id_reserva`),
  KEY `idx_reserva_solicitante` (`solicitante_id`),
  KEY `idx_reserva_estado` (`estado_reserva_id`),
  KEY `idx_reserva_rango_fechas` (`fecha_inicio`,`fecha_fin`),
  CONSTRAINT `fk_reserva_estado` FOREIGN KEY (`estado_reserva_id`) REFERENCES `estado_reserva` (`id_estado_reserva`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reserva_usuario` FOREIGN KEY (`solicitante_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_reserva_secuencia_fechas` CHECK ((`fecha_fin` > `fecha_inicio`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 19
DROP TABLE IF EXISTS `recurso_reserva`;

CREATE TABLE `recurso_reserva` (
  `reserva_id` bigint unsigned NOT NULL COMMENT 'Llave primaria compuesta (Parte 1). Enlace directo a la reserva matriz.',
  `recurso_id` bigint unsigned NOT NULL COMMENT 'Llave primaria compuesta (Parte 2). Enlace al recurso físico asignado a la reserva.',
  `cantidad` int unsigned NOT NULL DEFAULT '1' COMMENT 'Número de unidades solicitadas de este recurso específico en la reserva. Por defecto es 1.',
  PRIMARY KEY (`reserva_id`,`recurso_id`),
  KEY `idx_recurso_reserva_recurso` (`recurso_id`),
  CONSTRAINT `fk_recurso_reserva_recurso` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id_recurso`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_recurso_reserva_reserva` FOREIGN KEY (`reserva_id`) REFERENCES `reserva` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 20
DROP TABLE IF EXISTS `aprobacion`;

CREATE TABLE `aprobacion` (
  `id_aprobacion` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del registro de aprobación.',
  `reserva_id` bigint unsigned NOT NULL COMMENT 'Enlace directo a la solicitud de reserva evaluada.',
  `usuario_id` bigint unsigned NOT NULL COMMENT 'ID del usuario responsable de evaluar y emitir la aprobación o rechazo de la reserva.',
  `estado_aprobacion_id` int unsigned NOT NULL COMMENT 'Estado final de la evaluación de la reserva (Aprobada, Rechazada, Pendiente).',
  `fecha_respuesta` datetime DEFAULT NULL COMMENT 'Fecha y hora exacta en la que el usuario responsable emitió la decisión de aprobación o rechazo de la reserva.',
  `observacion` text COMMENT 'Observaciones o justificación registradas durante el proceso de evaluación de la reserva.',
  PRIMARY KEY (`id_aprobacion`),
  UNIQUE KEY `uq_aprobacion_reserva` (`reserva_id`),
  KEY `idx_aprobacion_usuario` (`usuario_id`),
  KEY `idx_aprobacion_estado_aprobacion_id` (`estado_aprobacion_id`),
  CONSTRAINT `fk_aprobacion_estado` FOREIGN KEY (`estado_aprobacion_id`) REFERENCES `estado_aprobacion` (`id_estado_aprobacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_aprobacion_reserva` FOREIGN KEY (`reserva_id`) REFERENCES `reserva` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aprobacion_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 21
DROP TABLE IF EXISTS `incidencia`;

CREATE TABLE `incidencia` (
  `id_incidencia` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de la incidencia o ticket de soporte.',
  `prioridad_id` int unsigned NOT NULL COMMENT 'Enlace al catálogo de niveles de prioridad e impacto del ticket (Ej: Alta, Media, Baja).',
  `tipo_incidencia_id` int unsigned NOT NULL COMMENT 'Vínculo a la categoría de la falla (Ej: Falla de Hardware, Caída de Red, Infraestructura).',
  `estado_incidencia_id` int unsigned NOT NULL COMMENT 'Enlace al catálogo maestro de estados de incidencia (Abierta, Asignada, En Proceso, Cerrada).',
  `recurso_id` bigint unsigned DEFAULT NULL COMMENT 'ID del recurso físico afectado. Si se deja en NULL, representa una incidencia general de las instalaciones.',
  `reportada_por_id` bigint unsigned NOT NULL COMMENT 'ID del usuario (solicitante o agente) que descubrió y registró la falla en la plataforma.',
  `usuario_asignado_id` bigint unsigned DEFAULT NULL COMMENT 'ID del agente o técnico de soporte encargado oficial de resolver la avería.',
  `asunto` varchar(200) NOT NULL COMMENT 'Título breve o resumen conciso del problema (Ej: El proyector del Aula 3 no enciende).',
  `descripcion` text COMMENT 'Explicación detallada, síntomas del problema o contexto extra aportado por el reportante.',
  `fecha_reporte` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y segundo exacto en el que el ticket se registró nativamente en el sistema.',
  `fecha_resolucion_estimada` datetime DEFAULT NULL COMMENT 'Fecha compromiso calculada por el sistema o el agente para dar una solución tentativa.',
  `fecha_resolucion_real` datetime DEFAULT NULL COMMENT 'Pista de auditoría gerencial. Captura el momento exacto del cierre definitivo para calcular la métrica MTTR.',
  PRIMARY KEY (`id_incidencia`),
  KEY `idx_incidencia_prioridad_id` (`prioridad_id`),
  KEY `idx_incidencia_tipo_incidencia_id` (`tipo_incidencia_id`),
  KEY `idx_incidencia_estado_incidencia_id` (`estado_incidencia_id`),
  KEY `idx_incidencia_recurso` (`recurso_id`),
  KEY `idx_incidencia_reportante` (`reportada_por_id`),
  KEY `idx_incidencia_usuario_estado` (`usuario_asignado_id`,`estado_incidencia_id`),
  KEY `idx_incidencia_dashboard_estado_prioridad` (`estado_incidencia_id`,`prioridad_id`,`fecha_reporte`),
  CONSTRAINT `fk_incidencia_estado` FOREIGN KEY (`estado_incidencia_id`) REFERENCES `estado_incidencia` (`id_estado_incidencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_incidencia_prioridad` FOREIGN KEY (`prioridad_id`) REFERENCES `prioridad` (`id_prioridad`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_incidencia_recurso` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id_recurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_incidencia_reportante` FOREIGN KEY (`reportada_por_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_incidencia_tipo` FOREIGN KEY (`tipo_incidencia_id`) REFERENCES `tipo_incidencia` (`id_tipo_incidencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_incidencia_usuario_asignado` FOREIGN KEY (`usuario_asignado_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_incidencia_fechas` CHECK (((`fecha_resolucion_real` is null) or (`fecha_resolucion_real` >= `fecha_reporte`)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 22
DROP TABLE IF EXISTS `adjunto`;

CREATE TABLE `adjunto` (
  `id_adjunto` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada archivo adjunto registrado.',
  `incidencia_id` bigint unsigned NOT NULL COMMENT 'Enlace directo a la incidencia o ticket de soporte al que pertenece el archivo de evidencia.',
  `ruta_archivo` varchar(255) NOT NULL COMMENT 'Dirección de almacenamiento lógico o URL física donde reside el archivo en el servidor o la nube (Ej: /uploads/incidencias/img_100.png).',
  `nombre_archivo` varchar(100) NOT NULL COMMENT 'Nombre comercial u original del archivo cargado por el usuario para su despliegue visual (Ej: pantalla_rota.png).',
  PRIMARY KEY (`id_adjunto`),
  KEY `idx_adjunto_incidencia` (`incidencia_id`),
  CONSTRAINT `fk_adjunto_incidencia` FOREIGN KEY (`incidencia_id`) REFERENCES `incidencia` (`id_incidencia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 23
DROP TABLE IF EXISTS `comentario`;

CREATE TABLE `comentario` (
  `id_comentario` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada comentario u observación en el chat de la incidencia.',
  `incidencia_id` bigint unsigned NOT NULL COMMENT 'Enlace directo a la incidencia o ticket de soporte al que pertenece el hilo de conversación.',
  `autor_id` bigint unsigned NOT NULL COMMENT 'ID del usuario (solicitante o agente) que redactó y publicó el mensaje en la plataforma.',
  `texto` text NOT NULL COMMENT 'Contenido de texto libre del mensaje (Ej: El técnico ya cambió la lámpara del proyector).',
  `fecha_hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Sello de tiempo automático que registra el segundo exacto en el que se publicó el comentario.',
  PRIMARY KEY (`id_comentario`),
  KEY `idx_comentario_incidencia` (`incidencia_id`),
  KEY `idx_comentario_autor` (`autor_id`),
  CONSTRAINT `fk_comentario_incidencia` FOREIGN KEY (`incidencia_id`) REFERENCES `incidencia` (`id_incidencia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comentario_usuario` FOREIGN KEY (`autor_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 24
DROP TABLE IF EXISTS `historial_estado`;

CREATE TABLE `historial_estado` (
  `id_historial_estado` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada registro de transición de estados.',
  `incidencia_id` bigint unsigned NOT NULL COMMENT 'Enlace directo a la incidencia o ticket de soporte que sufrió la modificación de estado.',
  `id_estado_incidencia` int unsigned NOT NULL COMMENT 'ID del nuevo estado al que transitó la incidencia.',
  `actor_id` bigint unsigned NOT NULL COMMENT 'ID del usuario (agente de soporte o administrador) que ejecutó físicamente el cambio de estado.',
  `fecha_cambio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Sello de tiempo automático que registra el segundo exacto en el que ocurrió la transición de estado.',
  PRIMARY KEY (`id_historial_estado`),
  KEY `idx_historial_estado_incidencia` (`incidencia_id`),
  KEY `idx_historial_estado_catalogo` (`id_estado_incidencia`),
  KEY `idx_historial_estado_usuario` (`actor_id`),
  CONSTRAINT `fk_historial_estado_catalogo` FOREIGN KEY (`id_estado_incidencia`) REFERENCES `estado_incidencia` (`id_estado_incidencia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_historial_estado_incidencia` FOREIGN KEY (`incidencia_id`) REFERENCES `incidencia` (`id_incidencia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_historial_estado_usuario` FOREIGN KEY (`actor_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 25
DROP TABLE IF EXISTS `registro_trabajo`;

CREATE TABLE `registro_trabajo` (
  `id_registro_trabajo` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada parte de trabajo técnico.',
  `incidencia_id` bigint unsigned NOT NULL COMMENT 'Enlace directo a la incidencia o avería en la que se trabajó.',
  `usuario_id` bigint unsigned NOT NULL COMMENT 'ID del usuario técnico que realizó y registró esta intervención sobre la incidencia.',
  `tipo_intervencion_id` int unsigned NOT NULL COMMENT 'Tipo de intervención realizada durante este registro de trabajo.',
  `descripcion` text NOT NULL COMMENT 'Informe técnico detallado que describe las acciones, reparaciones o diagnósticos realizados.',
  `tiempo_dedicado_minutos` int unsigned NOT NULL COMMENT 'Duración total del trabajo expresada en minutos. Clave para calcular el costo de soporte y la eficiencia.',
  `fecha_inicio_trabajo` datetime NOT NULL COMMENT 'Fecha y hora exacta en la que el agente comenzó a trabajar en esta tarea.',
  `fecha_fin_trabajo` datetime NOT NULL COMMENT 'Fecha y hora exacta en la que el agente dio por finalizada esta tarea específica.',
  PRIMARY KEY (`id_registro_trabajo`),
  KEY `idx_registro_trabajo_usuario` (`usuario_id`),
  KEY `idx_registro_trabajo_incidencia` (`incidencia_id`),
  KEY `idx_registro_trabajo_tipo_intervencion` (`tipo_intervencion_id`),
  CONSTRAINT `fk_registro_trabajo_incidencia` FOREIGN KEY (`incidencia_id`) REFERENCES `incidencia` (`id_incidencia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_registro_trabajo_tipo_intervencion` FOREIGN KEY (`tipo_intervencion_id`) REFERENCES `tipo_intervencion` (`id_tipo_intervencion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_registro_trabajo_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_registro_trabajo_duracion_positiva` CHECK ((`tiempo_dedicado_minutos` > 0)),
  CONSTRAINT `chk_registro_trabajo_rango_fechas` CHECK ((`fecha_fin_trabajo` >= `fecha_inicio_trabajo`))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 26
DROP TABLE IF EXISTS `log_auditoria`;

CREATE TABLE `log_auditoria` (
  `id_log` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del registro de auditoría.',
  `actor_id` bigint unsigned NOT NULL COMMENT 'ID del usuario (solicitante o agente) que ejecutó físicamente la acción en el sistema.',
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha, hora y segundo exacto en el que ocurrió el evento transaccional.',
  `objeto_id` bigint unsigned NOT NULL COMMENT 'ID de la llave primaria de la entidad afectada (Ej: id_reserva, id_incidencia, id_recurso).',
  `tipo_accion` varchar(50) NOT NULL COMMENT 'Tipo de operación de base de datos realizada (Ej: INSERT, UPDATE, DELETE, LOGIN_FALLIDO).',
  `tipo_objeto` varchar(50) NOT NULL COMMENT 'Nombre de la tabla técnica afectada (Ej: RESERVA, INCIDENCIA, RECURSO) para mapear el contexto.',
  `valor_nuevo` text COMMENT 'Estado del dato en formato JSON o texto posterior a la ejecución del cambio.',
  `valor_anterior` text COMMENT 'Estado del dato original previo a la transacción. Esencial para procesos de reversión o rollback informativo.',
  `direccion_ip` varchar(45) DEFAULT NULL COMMENT 'Dirección de red IPv4 o IPv6 del dispositivo desde el cual se originó la petición web para auditoría forense.',
  PRIMARY KEY (`id_log`),
  KEY `idx_log_auditoria_actor_fecha` (`actor_id`,`fecha_registro`),
  KEY `idx_log_auditoria_objeto_tipo` (`tipo_objeto`,`objeto_id`),
  CONSTRAINT `fk_log_auditoria_usuario` FOREIGN KEY (`actor_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 27
DROP TABLE IF EXISTS `reporte`;

CREATE TABLE `reporte` (
  `id_reporte` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única del reporte generado.',
  `nombre_reporte` varchar(200) NOT NULL COMMENT 'Título o etiqueta descriptiva del informe analítico (Ej: Rendimiento de Equipos de Soporte Q1).',
  `datos_json` json DEFAULT NULL COMMENT 'Almacenamiento nativo no relacional (NoSQL) dentro de MySQL. Guarda la captura consolidada del informe para maxima flexibilidad.',
  `fecha_generacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y segundo exacto en el que se compiló y guardó el informe en el sistema.',
  `generado_por_id` bigint unsigned NOT NULL COMMENT 'ID del usuario (administrador o directivo) que ordenó la compilación del reporte.',
  PRIMARY KEY (`id_reporte`),
  KEY `idx_reporte_generador` (`generado_por_id`),
  CONSTRAINT `fk_reporte_usuario` FOREIGN KEY (`generado_por_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- 28
DROP TABLE IF EXISTS `reporte_filtro`;

CREATE TABLE `reporte_filtro` (
  `id_reporte_filtro` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria auto-incremental única de cada criterio de filtrado.',
  `reporte_id` bigint unsigned NOT NULL COMMENT 'Enlace al reporte matriz al que pertenece este sub-criterio.',
  `nombre_filtro` varchar(100) NOT NULL COMMENT 'Nombre técnico de la variable clave utilizada para el filtro (Ej: fecha_desde, tipo_recurso_id, estado_incidencia).',
  `valor` varchar(255) NOT NULL COMMENT 'Valor asignado a la variable clave del filtro (Ej: 2026-01-01, 5, ABIERTA). Almacenado como texto para maxima flexibilidad.',
  PRIMARY KEY (`id_reporte_filtro`),
  KEY `idx_reporte_filtro_reporte` (`reporte_id`),
  CONSTRAINT `fk_reporte_filtro_reporte` FOREIGN KEY (`reporte_id`) REFERENCES `reporte` (`id_reporte`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
