CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_CHECKLISTE as
   -- 20080313 einzel_massnahme + teil_massnahme_id NULL gesetzt
   -- 20081216: checkliste_gruppe_id NULL gesetzt
   -- 20081216: join zur cpr_suchfeld_spr_zu, um cpr_suchfeld zu bekommen
   -- 20081216: teil_massn_fg wird zu teil_massn_kz
   -- 20081216: Aktuellster Satz durch " dat_bis = '9999-12-31' " Einschränkung
   -- 20090114: cpr_suchfeld wird wieder geliefert statt suchfeld_bez
   -- 20090205: Ausgabe von Mandant_id, dazu join der Hierachie bis cpr_projekt_per
   -- 20140110: kkaiser, aenderbar_fg ausgebaut, wird im FE nicht benötigt
   SELECT
   cl.cpr_checkliste_id, cl.projekt_phase_id, cl.cpr_ext_id  AS checkliste_nr, cl.checklistenart_id, CAST(NULL AS VARCHAR(40)) AS checkliste_gruppe_id, cl.sap_user, cl.nicht_relevant_fg, cl.dat_aufloesung, su.cpr_suchfeld   AS cpr_suchfeld, cl.teil_massn_kz   AS teil_massn_fg, cl.cpr_systemstatus1_id, cl.cpr_systemstatus2_id, cl.cpr_systemstatus3_id, pr.mandant_id

   FROM dbp_view.v_cpr_checkliste_per cl
   INNER JOIN dbp_view.v_cpr_phase_per   ph
   ON  cl.projekt_phase_id = ph.projekt_phase_id
   AND  ph.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_projekt_per  pr
   ON  ph.projekt_id = pr.projekt_id
   AND  pr.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_l_cpr_suchfeld su
   ON cl.cpr_suchfeld_id = su.cpr_suchfeld_id

   WHERE
   cl.dat_bis = '9999-12-31'
   ;