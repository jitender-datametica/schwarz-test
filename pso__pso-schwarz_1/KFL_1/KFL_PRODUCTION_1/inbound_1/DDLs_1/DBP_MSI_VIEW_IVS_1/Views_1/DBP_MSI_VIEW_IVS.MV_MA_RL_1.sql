CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MA_RL_1 as
               -- 2013-10-11
               -- LOOKUP Regionalleiter Vermietung
               -- 2013KW46 Initial, neue Hierarchieebene

               SELECT DISTINCT
               zu.mandant_id,
               ozu.zustaendig_typ_id,
               zu.zustaendig_id                       AS rl_ma_id,
               dbp_process.transcriptc(zu.vorname)    AS rl_vorname,
               dbp_process.transcriptc(zu.nachname)   AS rl_nachname,
               dbp_process.transcriptc(zu.anrede)     AS rl_anrede,
               TRIM(rl_anrede || ' ' || rl_vorname || ' ' || rl_nachname) AS rl_name

              FROM dbp_view.v_ivs_immo_zustaendig_1  zu

               JOIN dbp_view.v_ivs_objekt_zustaendig_zu_per_1  ozu
               ON  ozu.zustaendig_id = zu.zustaendig_id
               AND ozu.mandant_id = zu.mandant_id
               AND ozu.zustaendig_typ_id = 3
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
              FROM dbp_view.v_mandant_1 mdt;