# Quiniela

Plataforma web de quinielas deportivas (predicción de resultados de torneos por
eliminatoria/grupos), con ranking de participantes y cálculo automático de puntos.

Este proyecto nació para el Mundial 2026, pero está pensado para reutilizarse en
futuros torneos (otro Mundial, Champions League, Copa América, etc.), ajustando
la estructura del cuadro de eliminatoria y los datos de equipos/grupos.

## Stack

- **Backend (`quinela-bk`):** .NET (C#), Entity Framework Core, PostgreSQL. Arquitectura
  en capas: `Api`, `Application`, `Domain`, `Infrastructure`.
- **Frontend (`quinela-ft`):** Next.js.
- **Infraestructura:** Docker Compose (API, frontend, PostgreSQL, Caddy como reverse
  proxy/HTTPS).


## Estructura del repositorio
```
quiniela/
├── quinela-bk/ # API backend (.NET)
├── quinela-ft/ # Frontend (Next.js)
├── scripts/ # Scripts operativos (backups, etc.)
├── CHANGELOG.md # Ajustes manuales hechos en producción, no reflejados en código
└── .env # Variables de entorno de la instancia original (ver advertencia abajo)
```


## Cómo levantarlo

1. Cloná el repo en el nuevo servidor.
2. Ajustá el `.env` con credenciales nuevas para la instancia (no reutilices las de
   este archivo si son de un servidor anterior ya dado de baja).
3. Corré `docker compose up -d` (o el comando equivalente según el `docker-compose.yml`
   presente en cada subcarpeta).
4. Aplicá las migraciones de Entity Framework para crear el esquema de base de datos.
5. Cargá los datos iniciales del torneo (equipos, grupos, fixture) — ver sección
   siguiente.

## Adaptar a un torneo nuevo

El cuadro de eliminatoria está definido en un JSON embebido en el backend
(`BracketMundial2026.json`), con la estructura oficial de un Mundial de 48 equipos
(dieciseisavos, octavos, cuartos, semis, tercer puesto, final). Para un torneo con
otro formato, hay que:

- Crear un JSON nuevo con la cantidad de partidos y rondas correspondientes.
- Ajustar los seeds de equipos, grupos y tipos de partido.
- Revisar `DistributionEliminatoryWorldCup2026.cs` si el nuevo torneo no maneja
  "mejores terceros" o tiene una lógica de clasificación distinta.

Ver `CHANGELOG.md` para detalles de bugs conocidos y fixes aplicados manualmente
en la base de datos de la instancia del Mundial 2026, que conviene resolver a nivel
de código antes de reutilizar el proyecto.

## Scripts

- `scripts/backup-db.sh`: dump diario de las bases de datos vía `pg_dump`,
  comprimido y subido a Google Drive con `rclone`. Requiere `rclone.conf`
  configurado en el servidor (no incluido en este repo).

## ⚠️ Nota de seguridad

Este repositorio incluye un `.env` con credenciales reales de la instancia original
(servidor ya dado de baja). Si se reutiliza este proyecto, generar credenciales
nuevas y no reutilizar las presentes en este archivo.
