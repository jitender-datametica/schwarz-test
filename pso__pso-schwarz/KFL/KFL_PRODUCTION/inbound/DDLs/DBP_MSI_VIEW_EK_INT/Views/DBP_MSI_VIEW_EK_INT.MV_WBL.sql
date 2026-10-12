CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WBL
-- Filter auf wbl_id > 000 wurde entfernt, damit Umsätze im VS Cockpit enthalten sind.
-- In anderen Sichten wird zek_id im Dataset herausgefiltert / sschuecke 13.12.2018
(
mandant_id
,wbl_id
,wbl_dat_von
,wbl_name
)
AS
   SELECT
   mandant_id, wbl_id, wbl_dat_von, wbl_name
   FROM dbp_view.v_wbl;