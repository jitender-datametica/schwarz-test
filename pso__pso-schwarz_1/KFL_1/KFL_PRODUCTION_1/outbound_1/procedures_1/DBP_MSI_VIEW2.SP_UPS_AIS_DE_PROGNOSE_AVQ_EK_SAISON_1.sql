CREATE OR REPLACE PROCEDURE dbp_msi_view2.sp_ups_ais_de_prognose_avq_ek_saison(IN P_CLUSTER_ID INT64, IN P_DAT STRING, IN P_SAISON_MENGE_ABSATZ_PROGNOSE NUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_msi_view2.ts_ais_de_prognose_avq_ek_saison_tag_1 AS TARGET
USING (SELECT P_CLUSTER_ID AS cluster_id, P_DAT AS dat, P_SAISON_MENGE_ABSATZ_PROGNOSE AS saison_menge_absatz_prognose) AS source
ON TARGET.ek_saison_id = source.cluster_id AND TARGET.dat_prognose = CAST(source.dat AS DATE)
WHEN MATCHED THEN UPDATE SET
    menge_absatz_prognose = source.saison_menge_absatz_prognose
WHEN NOT MATCHED THEN INSERT (mandant_id, ek_saison_id, dat_prognose, menge_absatz_prognose) VALUES(1, CAST(source.cluster_id AS INTEGER), CAST(source.dat AS DATE), source.saison_menge_absatz_prognose);
COMMIT TRANSACTION;
SET out_param  =  'Absatzprognose geaendert';
SELECT out_param;
RETURN;
END;

