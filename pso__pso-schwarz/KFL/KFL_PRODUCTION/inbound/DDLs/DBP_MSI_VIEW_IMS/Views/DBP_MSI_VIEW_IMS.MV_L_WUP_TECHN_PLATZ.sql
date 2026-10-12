CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_WUP_TECHN_PLATZ AS
--03.05.2013 twie: von VIS übernommen, ohne Flächendaten
--24.06.2013 twie: ginfo_markt_typ entfernt, kommt aus Standort/Planungselement

   SELECT
   wp.mandant_id,
   wp.nb_id,
   wp.wup_id,
   tpl.techn_platz_id,
   COALESCE(tpl2.baujahr, 9999) AS baujahr,
   COALESCE(tpl2.ginfo_bauform_id, -1) AS ginfo_bauform_id,
   tpl2.anz_kassen


   FROM
   ( -- Marktstamm
   SELECT mandant_id,
   nb_id,
   wup_id
  FROM dbp_view.v_wup
  ) wp
   LEFT OUTER JOIN
   ( -- Techn. Platz
   SELECT mandant_id,
   techn_platz_id,
   wup_id
  FROM dbp_view.v_techn_platz_per
  WHERE techn_platz_ebene_id = 2 AND dat_bis = '9999-12-31'
  ) tpl
   ON wp.mandant_id = tpl.mandant_id
   AND wp.wup_id = tpl.wup_id
   LEFT OUTER JOIN
   ( -- Techn Platz Ebene 2
   SELECT
   s01.mandant_id,
   s01.techn_platz_id,
   s01.baujahr,
   s01.ginfo_markt_typ,
   s01.ginfo_bauform_id,
   s01.anz_kassen

  FROM dbp_view.v_techn_platz_ebene_2_per  s01

   WHERE s01.dat_bis = '9999-12-31'
   ) tpl2
   ON   tpl.techn_platz_id = tpl2.techn_platz_id;