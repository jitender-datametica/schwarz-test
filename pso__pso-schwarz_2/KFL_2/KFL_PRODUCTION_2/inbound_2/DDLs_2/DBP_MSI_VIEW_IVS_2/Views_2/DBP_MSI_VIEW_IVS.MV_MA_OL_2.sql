CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MA_OL_2 as
      -- 2013-10-11
      -- LOOKUP Objektleiter Vermietung
      -- 2013KW46 Initial, neu erstellt

      SELECT DISTINCT
      zu.mandant_id,
      ozu.zustaendig_typ_id,
      zu.zustaendig_id                       AS ol_ma_id,
      dbp_process.transcriptc(zu.vorname)    AS ol_vorname,
      dbp_process.transcriptc(zu.nachname)   AS ol_nachname,
      COALESCE(dbp_process.transcriptc(zu.anrede),'')            AS ol_anrede,
      TRIM(ol_anrede || ' ' || ol_vorname || ' ' || ol_nachname) AS ol_name

     FROM dbp_view.v_ivs_immo_zustaendig_2  zu

      JOIN dbp_view.v_ivs_objekt_zustaendig_zu_per_2  ozu
      ON  ozu.zustaendig_id = zu.zustaendig_id
      AND ozu.mandant_id = zu.mandant_id
      AND ozu.zustaendig_typ_id = 2
      AND ozu.dat_bis = '9999-12-31'

      WHERE zu.zustaendig_id <> 0

      UNION ALL
      SELECT
      mdt.mandant_id,
      3::INTEGER,
      0::INTEGER,
      'ohne',
      'Zuordnung',
      '',
      'ohne Zuordnung'
     FROM dbp_view.v_mandant_2 mdt;