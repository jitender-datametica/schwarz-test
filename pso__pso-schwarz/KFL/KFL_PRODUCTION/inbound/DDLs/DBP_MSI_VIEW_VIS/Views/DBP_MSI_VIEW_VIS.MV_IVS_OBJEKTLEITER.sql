CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_OBJEKTLEITER
AS
   -- 2012KW25 : Initial von IVS nach VIS
   -- 2013KW02 :Transkription

   SELECT
   o.mandant_id, o.zustaendig_id                          AS Mitarbeiter_ID, MAX(dbp_process.transcriptc(z.vorname))  AS vorname, MAX(dbp_process.transcriptc(z.nachname)) AS nachname, MAX(z.anrede)                            AS anrede
   FROM dbp_view.v_ivs_objekt_zustaendig_zu_per  o

   JOIN dbp_view.v_ivs_immo_zustaendig  z
   ON   o.zustaendig_id = z.zustaendig_id
   AND  o.mandant_id = z.mandant_id

   WHERE o.zustaendig_typ_id = 2
   AND   dat_bis = '9999-12-31'

   GROUP BY
   o.mandant_id
   , o.zustaendig_id
   ;