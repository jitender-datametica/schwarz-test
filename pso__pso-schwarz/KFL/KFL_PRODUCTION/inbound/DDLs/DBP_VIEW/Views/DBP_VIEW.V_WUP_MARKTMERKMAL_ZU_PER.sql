CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_MARKTMERKMAL_ZU_PER
AS SELECT
mandant_id,
wup_guid,
wup_id,
nb_id,
dat_von,
dat_bis,
marktmerkmal_id,
marktmerkmal_wert,
TD_UPDATE ,
TD_INSERT
FROM dbp_data.wup_marktmerkmal_zu_per;


