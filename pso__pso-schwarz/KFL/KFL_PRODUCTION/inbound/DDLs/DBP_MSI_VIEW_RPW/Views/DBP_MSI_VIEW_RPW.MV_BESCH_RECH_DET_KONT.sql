CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_RECH_DET_KONT
       (
       system_id
       ,mandant_id
       ,rech_beleg_id
       ,rech_beleg_kont_pos_id
       ,gj
       ,kontierungsblock_nr
       ,row_grund_id
       ,dat_row
       ,menge
       ,basismenge_einh_id
       ,sap_mwst_id
       ,art_id
       ,betrag_beleg
       ,dat_bezug
       ,wg_id
       ,arthiertyp_id
       ,buch_grund_int_id
       ,buch_grund_ext_id
       ,menge_gp_best
       ,betrag_gp_best
       ,gp_fehlerart_id
       ,korrekturart_id
       ,betrag_gp_fehler_netto
       ,rech_kontoart_id
       ,sperrgrund_betrag_fg
       ,wup_id
       ,nb_id
       ,betrag_netto
       ,retourenpos_fg
       ,dat_rpw
       ,dat_buch
       ,dat_beleg
       ,dat_erfasst
       ,dat_rech_eingang
       ,pos_manuell_erstellt_fg
       )
       AS
          SELECT
7,
          brd.mandant_id,
          brd.rech_beleg_id,
          brd.rech_beleg_kont_pos_id,
          brd.gj,
          brd.kontierungsblock_nr,
          COALESCE(brd.row_grund_id ,'0') AS row_grund_id,
          brd.dat_row,
          brd.menge,
          brd.basismenge_einh_id,
          brd.sap_mwst_id,
          brd.art_id,
          brd.betrag_beleg,
          brd.dat_bezug,
          CASE WHEN brd.wg_id IS NULL THEN -3 ELSE brd.wg_id END AS wg_id,
          brd.arthiertyp_id,
          COALESCE (brd.buch_grund_int_id, '0') AS buch_grund_int_id,
          COALESCE (brd.buch_grund_ext_id,'0') AS buch_grund_ext_id,
          brd.menge_gp_best,
          brd.betrag_gp_best,
          COALESCE (brd.gp_fehlerart_id,'0') AS gp_fehlerart_id,
          COALESCE (brd.korrekturart_id,'0') AS korrekturart_id,
          brd.betrag_gp_fehler_netto,
          COALESCE (brd.rech_kontoart_id, '0') AS rech_kontoart_id,
          brd.sperrgrund_betrag_fg,
          br.wup_id,
          br.nb_id,
          brd.betrag_netto,
          brd.retourenpos_fg,
          ---CASE WHEN br.rech_beleg_status_id = '5' THEN CAST(br.dat_erfasst AS VARCHAR)  ELSE NULL END AS dat_rpw_,
          CASE WHEN br.rech_beleg_status_id = '5'  THEN to_date(br.dat_erfasst)  ELSE NULL END AS dat_rpw_,
          
          
          
          br.dat_buch,
          br.dat_beleg,
          br.dat_vorerfasst AS dat_erfasst,
          br.dat_rech_eingang,
          1 AS pos_manuell_erstellt_fg
          FROM dbp_view.v_besch_rech_det_kont brd

          JOIN dbp_view.v_besch_rech br
          ON br.mandant_id = brd.mandant_id
          AND br.rech_beleg_id = brd.rech_beleg_id
          AND br.gj = brd.gj

          WHERE brd.mandant_id = 1;