-- =============================================================================
-- 1. POBLADO DE CATÁLOGOS MAESTROS COMPLETOS (Capa 1)
-- =============================================================================

INSERT INTO `cargo` (`codigo`, `nombre`, `descripcion`) VALUES
('DIR_GENERAL', 'Director General / Rector', 'Maxima autoridad del instituto superior'),
('JEFE_ESTUDIOS', 'Jefe de Estudios', 'Responsable de la coordinacion academica y horarios'),
('PROF_TITULAR', 'Profesor Titular', 'Docente encargado de impartir asignaturas'),
('TECO_INFORMATICA', 'Tecnico de Informatica / Soporte', 'Encargado del mantenimiento de laboratorios y servidores'),
('CONSERJE', 'Personal de Conserjería', 'Responsable de la apertura de aulas y control fisico de llaves');

INSERT INTO `estado_aprobacion` (`nombre_estado`, `codigo`, `es_final`) VALUES
('Pendiente de Revision Jefatura', 'PENDIENTE', 0),
('Reserva Aprobada', 'APROBADO', 1),
('Reserva Denegada', 'RECHAZADO', 1);

INSERT INTO `estado_incidencia` (`nombre_estado`, `codigo`, `es_final`) VALUES
('Reportada por Docente', 'ABIERTA', 0),
('Asignada a Soporte TI', 'ASIGNADA', 0),
('En Reparacion / Configuracion', 'EN_PROCESO', 0),
('Solucion Temporal / Espera', 'RESUELTA', 0),
('Cerrada e Inalterable', 'CERRADA', 1);

INSERT INTO `estado_recurso` (`nombre_estado`, `codigo`) VALUES
('Disponible para Clase', 'DISPONIBLE'),
('En Uso por Docente', 'EN_PRESTAMO'),
('En Mantenimiento Tecnico', 'EN_MANTENIMIENTO'),
('Retirado del Inventario', 'BAJA_SISTEMA');

INSERT INTO `estado_reserva` (`nombre_estado`, `codigo`, `es_final`) VALUES
('Solicitud Recibida', 'PENDIENTE', 0),
('Horario Bloqueado / Confirmado', 'CONFIRMADA', 0),
('Recurso Entregado / En Clase', 'EN_USO', 0),
('Clase Finalizada / Devuelto', 'FINALIZADA', 1),
('Cancelada por el Profesor', 'CANCELADA', 1);

INSERT INTO `parametro_global` (`codigo`, `nombre`, `valor`, `tipo_dato`) VALUES
('MAX_HORAS_RESERVA', 'Duracion maxima por clase', '5', 'INTEGER'),
('EMAIL_SOPORTE_INSTI', 'Correo de alertas de laboratorios', 'soporte.ti@instituto.edu', 'EMAIL'),
('TIEMPO_TOLERANCIA_RECOJO', 'Minutos de tolerancia para recoger recursos', '20', 'INTEGER');

INSERT INTO `politica_prestamo` (`nombre`, `max_duracion_minutos`, `max_recursos_prestamo`, `max_dias_anticipacion`) VALUES
('Horario de Clase Estandar', 300, 1, 14),
('Prestamo para Examenes / Eventos', 600, 2, 30),
('Uso Libre / Tutorias Rapidas', 60, 1, 3);

INSERT INTO `prioridad` (`nombre`, `codigo`, `nivel`) VALUES
('Baja (No afecta la clase)', 'BAJA', 1),
('Media (Afecta parcialmente)', 'MEDIA', 2),
('Alta (Interrumpe la clase actual)', 'ALTA', 3),
('Critica (Bloquea laboratorios o examenes)', 'CRITICA', 4);

INSERT INTO `rol` (`nombre_rol`, `codigo`, `limite_reservas_activas`) VALUES
('Direccion y Jefatura', 'ADMIN', 99),
('Equipo Tecnico TI', 'AGENTE', 15),
('Cuerpo Docente', 'SOLICITANTE', 5);

INSERT INTO `tipo_incidencia` (`nombre_tipo`, `codigo`) VALUES
('Fallo de Hardware (PC, Proyector)', 'HARDWARE'),
('Cuelgue de Software / Licencias', 'SOFTWARE'),
('Sin Internet / Error de Red', 'RED'),
('Problema de Aula (Mobiliario, Luces)', 'INFRAESTRUCTURA');

INSERT INTO `tipo_intervencion` (`codigo`, `nombre`, `descripcion`) VALUES
('REVISION', 'Revision tecnica rapida', 'Inspeccion fisica en el aula durante el cambio de hora'),
('CAMBIO_PIEZA', 'Reemplazo de componente', 'Sustitucion de proyectores, cables HDMI o ratones defectuosos'),
('INST_SOFT', 'Instalacion de Programas', 'Configuracion de software educativo en laboratorios'),
('MANT_LIMPIEZA', 'Mantenimiento de Laboratorio', 'Soplado de PCs y actualizacion de antivirus');

INSERT INTO `tipo_recurso` (`nombre_tipo`, `codigo`) VALUES
('Carritos de Laptops / Portatiles', 'LAPTOP'),
('Aulas de Teoria y Laboratorios TI', 'ESPACIO'),
('Proyectores y Pizarras Digitales', 'PROYECTOR'),
('Kits de Electronica / Desarrollo', 'ACCESORIO');


-- =============================================================================
-- 2. REGISTROS TRANSACCIONALES ENTORNO ACADÉMICO (Capas 2, 3, 4 y 5)
-- =============================================================================

INSERT INTO `departamento` (`codigo`, `nombre`, `descripcion`) VALUES
('DEPT_INFORMATICA', 'Departamento de Informatica y Comunicaciones', 'Area a cargo de las carreras de Desarrollo de Software y Redes'),
('DEPT_ADMINISTRACION', 'Departamento de Administracion y Finanzas', 'Area de gestion academica y empresarial');

INSERT INTO `usuario` (`email`, `password_hash`, `nombre`, `apellidos`, `telefono`, `departamento_id`, `cargo_id`) VALUES
('jefe.estudios@instituto.edu', '\$2a\$10\$X.JimpsoftDummyHashAdminSecretPasswordDontUseInProd', 'Francisco', 'Javier', '985111222', 1, 2),
('soporte.laboratorios@instituto.edu', '\$2a\$10\$X.JimpsoftDummyHashTecnicoSecretPasswordDontUseInProd', 'Marcos', 'Sanchez', '985222333', 1, 4),
('profesor.java@instituto.edu', '\$2a\$10\$X.JimpsoftDummyHashEmpleadoSecretPasswordDontUseInProd', 'Manuel', 'Garcia', '985333444', 1, 3);

INSERT INTO `usuario_rol` (`id_usuario`, `id_rol`) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO `recurso` (`id_tipo_recurso`, `id_politica`, `id_estado_recurso`, `nombre`, `codigo_inv`, `ubicacion`) VALUES
(2, 1, 1, 'Laboratorio de Desarrollo de Software (Aula 304)', 'INST-LAB-304', 'Tercera Planta - Pabellon B'),
(1, 1, 1, 'Carrito de 15 Laptops HP ProBook', 'INST-CAR-02', 'Conserjería Principal'),
(3, 1, 1, 'Proyector EPSON de Techo Aula 102', 'INST-PROY-102', 'Primera Planta - Aula 102');

INSERT INTO `horario_recurso` (`id_horario`, `recurso_id`, `dia_semana`, `hora_inicio`, `hora_fin`) VALUES
(1, 1, 1, '08:00:00', '14:30:00'),
(2, 3, 1, '15:30:00', '21:30:00');

INSERT INTO `reserva` (`solicitante_id`, `estado_reserva_id`, `fecha_inicio`, `fecha_fin`) VALUES
(3, 2, '2026-10-12 08:30:00', '2026-10-12 11:30:00');

INSERT INTO `recurso_reserva` (`reserva_id`, `recurso_id`, `cantidad`) VALUES
(1, 1, 1);

INSERT INTO `incidencia` (`prioridad_id`, `tipo_incidencia_id`, `estado_incidencia_id`, `recurso_id`, `reportada_por_id`, `usuario_asignado_id`, `asunto`, `descripcion`) VALUES
(3, 3, 2, 1, 3, 2, 'PCs del fondo sin acceso a internet', 'En el Laboratorio 304, las computadoras de la fila del fondo no obtienen direccion IP.');