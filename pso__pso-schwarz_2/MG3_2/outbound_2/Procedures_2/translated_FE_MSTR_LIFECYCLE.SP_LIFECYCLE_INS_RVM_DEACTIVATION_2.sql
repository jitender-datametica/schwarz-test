CREATE OR REPLACE PROCEDURE fe_mstr_lifecycle.sp_lifecycle_ins_rvm_deactivation(IN p_rvm_sid INT64, IN p_inactive_dt DATE, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
--Deaktivierung von Pfandautomaten, vom Anwender in MSI eingetragen.
--Wird in dieser Zwischentabelle gespeichert, über Nacht von Backend abgeholt
--und in die CORE Tabelle geschrieben. Gibt es mehrere Datensätze pro Automat und Tag_2, wird der neueste genommen.
	--keine Inaktivierung in der Zukunft möglich
IF p_inactive_dt <= CURRENT_DATE THEN
    -- Automat hinzufügen
    INSERT INTO szd_production_fe_mstr_lifecycle.ts_dim_rvm_deact_2 (rvm_sid, rvm_active_id, inactive_dt, inserted_tmsp)
(SELECT CAST(p_rvm_sid AS INTEGER) AS rvm_sid, 0 AS rvm_active_id, p_inactive_dt AS inactive_dt, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS inserted_tmsp);
END IF;

COMMIT TRANSACTION;
SET out_param  =  'ok';
SELECT out_param;
RETURN;
END;
