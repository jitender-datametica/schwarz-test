CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_MANDANT_WRG_KURS_ZU_PER_2 as
   -- 20130307 Initial VIS auf Basis IVS : angepasste Version ohne Waehrungstyp

   SELECT
   mwt.mandant_id, mwt.wrg_id, CASE WHEN wrg_typ_id = 0 THEN lw.umrechnungskurs ELSE 1 END::NUMBER(38,5) AS kurs_2,  1/ kurs_2 AS umrechnungskurs
   FROM dbp_view.v_mandant_wrg_typ_zu_2  mwt
   INNER JOIN dbp_view.v_mandant_2  m
   ON mwt.mandant_id = m.mandant_id
   INNER JOIN dbp_view.v_kurs_2  lw
   ON lw.von_wrg_id = m.default_wrg
   AND lw.nach_wrg_id = 'EUR'
   AND lw.kurstyp_id = 3
   AND lw.dat_bis = '9999-12-31'

   WHERE (mwt.wrg_typ_id = 0 AND mwt.wrg_id = 'EUR')
   OR (mwt.wrg_typ_id = 1 AND mwt.wrg_id <> 'EUR')
   ;