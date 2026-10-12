--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.aktion

SET dat_von  = dat_von_
   ,dat_bis  = dat_bis_
   ,kjwo_von = kjwo_von_
   ,aktion_typ_id = aktion_typ_id_

FROM
(       SELECT DISTINCT
        mandant_id AS mandant_id_
        ,aktion_id AS aktion_id_
        ,dat_von AS dat_von_
        ,dat_bis AS dat_bis_
        ,aktion_typ_id AS aktion_typ_id_
        ,MIN(kjwo_von) OVER (PARTITION BY aktion_id_, mandant_id_) AS kjwo_von_
        FROM ${TEMP_TABLE} /*DBP_ETL.aktion_temp*/
) zz WHERE   mandant_id      = mandant_id_
AND     aktion_id       = aktion_id_
AND     aktion_id IS NOT NULL
;

