CREATE OR REPLACE PROCEDURE FE_MSTR_LIFECYCLE.SP_LIFECYCLE_INS_RVM_DEACTIVATION
(
		 p_rvm_sid NUMBER(38,0)
		,p_inactive_dt DATE
)
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN
--Deaktivierung von Pfandautomaten, vom Anwender in MSI eingetragen.
--Wird in dieser Zwischentabelle gespeichert, über Nacht von Backend abgeholt
--und in die CORE Tabelle geschrieben. Gibt es mehrere Datensätze pro Automat und Tag, wird der neueste genommen.
	--keine Inaktivierung in der Zukunft möglich
	IF (:p_inactive_dt <= CURRENT_DATE()) THEN
    -- Automat hinzufügen
    INSERT INTO FE_MSTR_LIFECYCLE.TS_DIM_RVM_DEACT
        (rvm_sid,
        rvm_active_id,
        inactive_dt,
        inserted_tmsp
        )
    VALUES
		(
		:p_rvm_sid,
		0,
        :p_inactive_dt,
        CURRENT_TIMESTAMP()
		)
    ;
	END IF;

COMMIT;

RETURN 'ok';

END;
$$;