CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_L_UMP_REFERENZ_1
-- 29/09/2019, cbru1709, Neuerstellung LU-Tabelle
(
referenzgrund_id
, referenzgrund_bez
)
AS
   SELECT
   referenzgrund_id, referenzgrund_bez
   FROM dbp_view.v_coi_l_ump_referenz_1
;