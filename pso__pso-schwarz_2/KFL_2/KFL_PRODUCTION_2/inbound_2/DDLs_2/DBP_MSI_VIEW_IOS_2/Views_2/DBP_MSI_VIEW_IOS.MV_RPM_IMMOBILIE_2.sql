--20241121 alavih: Anpassung bzgl. Filialumgliederung

CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_IMMOBILIE_2
(
rpm_immobilie_id --rpm_hierarchie_id RENAME
,dat_von
,techn_platz_id
,vs_id
,mandant_id
,wrg_id
,gesamtbew_note
,bewertungszahl_a
,bewertungszahl_b
,bewertungszahl_c
,dat_bis
,eigentum_bez
,beri_relevanz
,gj_umbvorschl
,wup_id
,nb_id
,wup_standort
,strasse
,plz
,zielumsatz_3gj
,dat_eroeffn_fb_imm
)
AS
   SELECT
   v01.rpm_hierarchie_id AS rpm_immobilie_id,
   v01.dat_von, v01.techn_platz_id,
   COALESCE(w.vs_id,0) AS vs_id,
   v01.mandant_id, v01.wrg_id,
   v01.gesamtbew_note,
   v01.bewertungszahl_a,
   v01.bewertungszahl_b,
   v01.bewertungszahl_c,
   v01.dat_bis,
   COALESCE(v07.rpm_feld_auspr_bez,'') AS eigentum_bez,
   COALESCE(v17.rpm_feld_auspr_bez,'') AS beri_relevanz,
   CASE WHEN v01.gj_umbvorschl IS NULL THEN 0  ELSE v01.gj_umbvorschl END AS gj_umbvorschl,
  -- v01.wup_id,
   COALESCE(w.aktuell_wup_id,v01.wup_id) AS wup_id, --Filterung auf aktuelle Filiale
   COALESCE(v01.nb_id,0) AS nb_id,
   COALESCE(v01.wup_standort,'') AS wup_standort,
   COALESCE(v01.strasse,'') AS strasse,
   v01.plz,
   v01.zielumsatz_3gj,
   v01.dat_eroeffn_fb_imm

   FROM dbp_view.v_rpm_immobilie_per_2 v01
   LEFT OUTER JOIN dbp_view.v_l_rpm_feld_2  v88
   ON v88.rpm_feld_id = 8
   LEFT OUTER JOIN dbp_view.v_rpm_feld_zu_per_2 v03
   ON v88.rpm_feld_id = v03.rpm_feld_id
   AND v01.rpm_hierarchie_id = v03.rpm_hierarchie_id
   AND v03.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_l_rpm_tab_2 v05
   ON v05.rpm_tab_bez ='INM_INITIATIVE'
   AND v03.rpm_tab_id = v05.rpm_tab_id
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_zu_2 v06
   ON v88.rpm_feld_id = v06.rpm_feld_id
   AND v05.rpm_tab_id = v06.rpm_tab_id
   AND v03.rpm_feld_auspr_id = v06.rpm_feld_auspr_id
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2 v07
   ON v07.rpm_feld_id = v06.rpm_feld_id
   AND v07.rpm_tab_id = v06.rpm_tab_id
   AND v07.rpm_feld_auspr_id = v06.rpm_feld_auspr_id
   AND v07.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_wup_2  w
   ON  v01.wup_id = w.wup_id AND v01.mandant_id = w.mandant_id AND v01.nb_id = w.nb_id
   AND v01.wup_id > 0
   LEFT OUTER JOIN dbp_view.v_l_rpm_feld_2  v77
   ON v77.rpm_feld_id = 31
   LEFT OUTER JOIN dbp_view.v_rpm_feld_zu_per_2 v13
   ON v77.rpm_feld_id = v13.rpm_feld_id
   AND v01.rpm_hierarchie_id = v13.rpm_hierarchie_id
   AND v13.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_l_rpm_tab_2 v15
   ON v15.rpm_tab_bez ='INM_INITIATIVE'
   AND v13.rpm_tab_id = v15.rpm_tab_id
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_zu_2 v16
   ON v77.rpm_feld_id = v16.rpm_feld_id
   AND v15.rpm_tab_id = v16.rpm_tab_id
   AND v13.rpm_feld_auspr_id = v16.rpm_feld_auspr_id
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2 v17
   ON v17.rpm_feld_id = v16.rpm_feld_id
   AND v17.rpm_tab_id = v16.rpm_tab_id
   AND v17.rpm_feld_auspr_id = v16.rpm_feld_auspr_id
   AND v17.spr_id = 22

   WHERE
   v01.dat_bis = '9999-12-31';