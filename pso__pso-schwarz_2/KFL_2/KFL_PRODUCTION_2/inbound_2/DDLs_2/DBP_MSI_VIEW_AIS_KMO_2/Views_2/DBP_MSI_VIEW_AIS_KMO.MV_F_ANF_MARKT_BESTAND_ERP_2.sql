CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_F_ANF_MARKT_BESTAND_ERP_2
AS
   -- AL 02.09.2013 Initial erstellt. Logik Endbestand des Vortages ist Anfangsbestand des Folgetages
   -- basiert extra auf mv View um den doppelten Pflegeaufwand in der View zu vermeiden
   --MC 17.10.13: Wegen Perfromance-Issues zusätzlichen Join auf die Tag_2 Tabelle --> keine inhaltliche Veränderung!

   SELECT

   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.stimmig_id,
   v02.dat + 1 AS dat,
   v01.wrg_id,
   v01.gp_id,
   v01.ds_markt_bestand_menge_frei AS an_markt_bestand_menge_frei,
   v01.ds_markt_bestand_menge_qual AS an_markt_bestand_menge_qual,
   v01.ds_markt_bestand_menge_ges AS an_markt_bestand_menge_ges,
   v01.ds_markt_bestand_ekn2_frei AS an_markt_bestand_ekn2_frei,
   v01.ds_markt_bestand_ekn2_qual AS an_markt_bestand_ekn2_qual,
   v01.ds_markt_bestand_ekn2_ges AS an_markt_bestand_ekn2_ges,
   v01.ds_markt_bestand_ekn4_frei AS an_markt_bestand_ekn4_frei,
   v01.ds_markt_bestand_ekn4_qual AS an_markt_bestand_ekn4_qual,
   v01.ds_markt_bestand_ekn4_ges AS an_markt_bestand_ekn4_ges,
   v01.ds_markt_bestand_vkn_frei AS an_markt_bestand_vkn_frei,
   v01.ds_markt_bestand_vkn_qual AS an_markt_bestand_vkn_qual,
   v01.ds_markt_bestand_vkn_ges AS an_markt_bestand_vkn_ges

  FROM dbp_msi_view_ais_kmo.mv_f_markt_bestand_erp_per_2 v01

   JOIN dbp_view.v_tag_2 v02
   ON v01.dat = v02.dat;