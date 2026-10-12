CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_EREIGNIS_SPR_ZU_2
(
ereignis_id
, ereignis_bez_lang
, ereignistyp_id
, mandant_id
, ereignis_bez_mittel
, ereignis_bez_kurz
)
AS
SELECT
v01.ereignis_id
, v01.ereignis_bez_lang
, v01.ereignistyp_id
, v01.mandant_id
, v01.ereignis_bez_mittel
, v01.ereignis_bez_kurz

FROM dbp_view.v_ereignis_spr_zu_2 v01

WHERE v01.spr_id = 22;