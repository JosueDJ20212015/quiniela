# Notas de esta instancia (Mundial 2026)

Este proyecto fue heredado de un desarrollo en conjunto. Este archivo documenta
ajustes manuales hechos directo en producción que NO están reflejados en el código,
para no perderlos si se reutiliza el proyecto en un futuro torneo.

## Fixes aplicados directo en la base de datos (no en código)

### Partido #89 (Francia vs Paraguay, Dieciseisavos) — 21 jul 2026
Bug: el backend (`DistributionEliminatoryWorldCup2026.cs`) resuelve local/visitante
de partidos de eliminatoria usando las columnas `partido_ganador_local_id` /
`partido_ganador_visitante_id` de la fila del partido — NO usa el JSON del bracket
como fuente de verdad si esas columnas ya tienen valor.
Al cargar el resultado real (Francia 1-0 Paraguay) estas columnas quedaron invertidas,
causando que el sistema recalculara mal quién avanzaba de ronda.
Fix: se invirtieron `partido_ganador_local_id`/`_visitante_id` para el partido id=89
directo en Postgres, alineándolos con equipo_local_id/equipo_visitante_id reales.

⚠ Si se reutiliza este proyecto, considerar blindar esta lógica (validación o
trigger) para que cargar un resultado no pueda desalinear estas columnas.

## Hardcodeos manuales pendientes de documentar
<!-- Completar acá cualquier otro cambio manual que hayas hecho sin que tu
compañero lo supiera, mientras lo recordás. -->

## Scripts
- `scripts/backup-db.sh`: dump diario de las bases `quinela` y `userapp` vía
  `pg_dump`, comprimido y subido a Google Drive con `rclone` (requiere
  `rclone.conf` configurado aparte, no incluido en este repo).
