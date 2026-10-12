--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.aktion SET
    dat_von = zz.dat_von_,
    dat_bis = zz.dat_bis_,
    kjwo_von = zz.kjwo_von_,
    aktion_typ_id = zz.aktion_typ_id_ FROM (SELECT DISTINCT
    mandant_id AS mandant_id_,
    aktion_id AS aktion_id_,
    dat_von AS dat_von_,
    dat_bis AS dat_bis_,
    aktion_typ_id AS aktion_typ_id_,
    MIN(kjwo_von) OVER (PARTITION BY aktion_id, mandant_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS
        kjwo_von_
FROM ${TEMP_TABLE}) AS zz
WHERE aktion.mandant_id = zz.mandant_id_ AND aktion.aktion_id = zz.aktion_id_;
