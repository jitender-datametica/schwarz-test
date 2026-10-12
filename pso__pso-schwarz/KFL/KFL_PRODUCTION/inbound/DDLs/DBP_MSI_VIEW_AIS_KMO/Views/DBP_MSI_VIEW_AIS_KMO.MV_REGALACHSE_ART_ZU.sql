CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REGALACHSE_ART_ZU
(
mandant_id
,regalachse_id
,art_id
,fachboden_nr
,fachboden_pos
,regional_kz
,kapazitaet
,kapazitaet_menge_einh_id
)
AS
   SELECT
   v01.mandant_id,
   v01.regalachse_id,
   v01.art_id,
   v01.fachboden_nr,
   v01.fachboden_pos,
   v01.regional_kz,
   v01.kapazitaet,
   v01.kapazitaet_menge_einh_id

   FROM dbp_view.v_regalachse_art_zu v01
   WHERE v01.mandant_id  <>1;