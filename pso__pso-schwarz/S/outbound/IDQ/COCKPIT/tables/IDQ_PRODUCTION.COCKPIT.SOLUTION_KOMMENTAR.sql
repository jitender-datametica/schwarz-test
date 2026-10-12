CREATE OR REPLACE TABLE idq_production_cockpit.solution_kommentar (
solution_id STRING(100) NOT NULL,
incidents_eskalationen STRING(100),
kommentar_incidents_eskalationen STRING(16777216),
anforderungspipeline STRING(100),
kommentar_anforderungspipeline STRING(16777216),
solutionreife STRING(100),
kommentar_solutionreife STRING(16777216),
reife_fachbereich STRING(100),
kommentar_reife_fachbereich STRING(16777216)
);