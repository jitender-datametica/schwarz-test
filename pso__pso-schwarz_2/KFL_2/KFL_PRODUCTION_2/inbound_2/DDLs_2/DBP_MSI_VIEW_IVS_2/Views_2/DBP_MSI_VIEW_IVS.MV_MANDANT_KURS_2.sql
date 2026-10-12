CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MANDANT_KURS_2 as
   SELECT
   m.mandant_id,
   m.default_wrg        land_wrg_id,
   k.nach_wrg_id        von_wrg_id,
   k.von_wrg_id         nach_wrg_id,
   TRUNC(1/k.umrechnungskurs)  umrechnungskurs,
   'LAND_2'::CHAR(4)     wrg_typ_id
   FROM dbp_view.v_mandant_2  m
   INNER JOIN dbp_view.v_kurs_2 k
   ON    k.dat_bis = '9999-12-31'
   AND   k.kurstyp_id = 3
   AND   m.default_wrg = k.von_wrg_id
   AND   k.von_wrg_id <> k.nach_wrg_id

   --WHERE m.mandant_id <> 4


   UNION ALL
   SELECT
   m.mandant_id,
   m.default_wrg        land_wrg_id,
   k.nach_wrg_id        von_wrg_id,
   k.nach_wrg_id,
   1                    umrechnungskurs,
   'EURO'::CHAR(4)     wrg_typ_id
   FROM dbp_view.v_mandant_2  m
   INNER JOIN dbp_view.v_kurs_2 k
   ON    k.dat_bis = '9999-12-31'
   AND   k.kurstyp_id = 3
   AND   m.default_wrg = k.von_wrg_id
;