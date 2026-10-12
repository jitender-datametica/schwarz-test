CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_VORSTAND_1 as
   -- 2012KW25: von IVS nach VIS übernommen
   -- 20120310 : Anpassung Join/Mandant_1

   SELECT
   o.mandant_id, o.zustaendig_id                               Mitarbeiter_ID, MAX(z.vorname)                                vorname, MAX(z.nachname)                               nachname, MAX(z.anrede)                                 anrede

   FROM dbp_view.v_ivs_objekt_zustaendig_zu_per_1  o

   JOIN dbp_view.v_ivs_immo_zustaendig_1  z
   ON  o.zustaendig_id = z.zustaendig_id
   AND o.mandant_id = z.mandant_id

   WHERE o.zustaendig_typ_id = 1
   AND   dat_bis = '9999-12-31'

   GROUP BY
   o.mandant_id
   , o.zustaendig_id
   ;