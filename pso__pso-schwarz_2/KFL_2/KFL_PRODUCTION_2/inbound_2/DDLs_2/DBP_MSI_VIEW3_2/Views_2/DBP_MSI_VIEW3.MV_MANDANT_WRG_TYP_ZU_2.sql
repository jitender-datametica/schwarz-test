CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MANDANT_WRG_TYP_ZU_2
-- 18.04.2012 srom, im Rahmen der Währungsauswahlberichte
(
mandant_id
, wrg_id
, wrg_typ_id
, wrg_typ_bez
)
AS
   SELECT
  mandant_id, wrg_id, wrg_typ_id, wrg_typ_bez

   FROM dbp_view.v_mandant_wrg_typ_zu_2
--WHERE mandant_id <> 1 OR wrg_typ_id = 1
;