CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MONAT_SPR_ZU_2
--11.01.2013SHoger initial
--20.02.2015 twie umgebaut

(
mo_gj
,mo_bez
)
AS
   SELECT

   CASE WHEN v01.mo_id >= 3 THEN v01.mo_id -2 ELSE v01.mo_id + 10 END AS mo_gj,
   v01.mo_bez

  FROM dbp_view.v_monat_spr_zu_2 v01

   WHERE v01.spr_id = 22 -- Deutsch
   ;