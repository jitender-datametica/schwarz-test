CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MANDANT_WRG_TYP_ZU_2
AS
-- 2009-03-11 NEU
-- materialisierte Mandant_2-Kurs_2-Zuordnung

SELECT
mandant_id
, wrg_id
, wrg_typ_id
, wrg_typ_bez

FROM dbp_view.v_mandant_wrg_typ_zu_2;