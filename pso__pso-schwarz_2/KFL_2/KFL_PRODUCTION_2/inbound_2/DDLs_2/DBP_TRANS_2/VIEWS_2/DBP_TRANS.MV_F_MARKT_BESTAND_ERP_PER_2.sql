create or replace view DBP_TRANS.MV_F_MARKT_BESTAND_ERP_PER_2(
	_UMKURS,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	STIMMIG_ID,
	DAT,
	WRG_ID,
	GP_ID,
	DS_MARKT_BESTAND_MENGE_FREI,
	DS_MARKT_BESTAND_MENGE_QUAL,
	DS_MARKT_BESTAND_MENGE_GES,
	DS_MARKT_BESTAND_EKN2_FREI,
	DS_MARKT_BESTAND_EKN2_QUAL,
	DS_MARKT_BESTAND_EKN2_GES,
	DS_MARKT_BESTAND_EKN4_FREI,
	DS_MARKT_BESTAND_EKN4_QUAL,
	DS_MARKT_BESTAND_EKN4_GES,
	DS_MARKT_BESTAND_VKN_FREI,
	DS_MARKT_BESTAND_VKN_QUAL,
	DS_MARKT_BESTAND_VKN_GES
) as
   SELECT
   CASE WHEN v03.wrg_typ_id = 1
   THEN CAST (1 AS NUMBER(38,5))
   ELSE v04.umrechnungskurs
   END                                                    AS _umkurs,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.relevant_fg AS stimmig_id,
   v01.dat,
   CASE WHEN v03.wrg_typ_id = 1
  THEN v02.wrg_id
  ELSE v04.nach_wrg_id
  END                                                                          AS _wrg_id,
   COALESCE (z.gp_id, -1)                                                       AS gp_id,
   v01.menge_lgbest_erp_frei_bme                                                AS ds_markt_bestand_menge_frei,
   v01.menge_lgbest_erp_qual_bme                                                AS ds_markt_bestand_menge_qual,
   CAST(v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_qual_bme AS NUMBER(38,5)) AS ds_markt_bestand_menge_ges,
   CAST ( (  (v01.menge_lgbest_erp_frei_bme * v02.vk_netto *    t04.kein_zekp_fg   * t04.ek_nettonetto)
   + (v01.menge_lgbest_erp_frei_bme                * (1-t04.kein_zekp_fg ) * t04.ek_nettonetto) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn2_frei,
   CAST ( (  (v01.menge_lgbest_erp_qual_bme * v02.vk_netto *    t04.kein_zekp_fg   * t04.ek_nettonetto)
   + (v01.menge_lgbest_erp_qual_bme                * (1-t04.kein_zekp_fg ) * t04.ek_nettonetto) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn2_qual,
   CAST ( (  (ds_markt_bestand_menge_ges    * v02.vk_netto *    t04.kein_zekp_fg   * t04.ek_nettonetto)
   + (ds_markt_bestand_menge_ges                   * (1-t04.kein_zekp_fg ) * t04.ek_nettonetto) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn2_ges,
   CAST ( (  (v01.menge_lgbest_erp_frei_bme * v02.vk_netto *    t04.kein_zekp_fg   * t04.einstandspreis)
   + (v01.menge_lgbest_erp_frei_bme                * (1-t04.kein_zekp_fg ) * t04.einstandspreis) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn4_frei,
   CAST ( (  (v01.menge_lgbest_erp_qual_bme * v02.vk_netto *    t04.kein_zekp_fg   * t04.einstandspreis)
   + (v01.menge_lgbest_erp_qual_bme                * (1-t04.kein_zekp_fg ) * t04.einstandspreis) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn4_qual,
   CAST ( (  (ds_markt_bestand_menge_ges    * v02.vk_netto *    t04.kein_zekp_fg   * t04.einstandspreis)
   + (ds_markt_bestand_menge_ges                   * (1-t04.kein_zekp_fg ) * t04.einstandspreis) )
   * _umkurs AS DECIMAL(18,4))                                               AS ds_markt_bestand_ekn4_ges,
   CAST(ds_markt_bestand_menge_frei * v02.vk_netto       * _umkurs AS NUMBER(38,5))    AS ds_markt_bestand_vkn_frei,
   CAST(ds_markt_bestand_menge_qual * v02.vk_netto       * _umkurs AS NUMBER(38,5))    AS ds_markt_bestand_vkn_qual,
   CAST(ds_markt_bestand_menge_ges  * v02.vk_netto       * _umkurs AS NUMBER(38,5))    AS ds_markt_bestand_vkn_ges
   

   FROM dbp_trans.marktbestand_erp_test v01

   JOIN dbp_trans.marktbestand_erp_zu_test v02
   ON  v01.mandant_id = v02.mandant_id
   AND v01.bestand_id = v02.bestand_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v03
   INNER JOIN dbp_view.v_kurs_2 v04
   ON  v02.wrg_id      = v04.von_wrg_id
   AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
   AND v04.kurstyp_id  = 9
   AND v04.nach_wrg_id = 'EUR'
   LEFT OUTER  JOIN dbp_view.v_art_gp_nm_zu_per_2  z
   ON  v01.mandant_id = z.mandant_id
   AND v01.art_id     = z.art_id
   AND v01.wup_id     = z.wup_id
   AND v01.dat BETWEEN z.dat_von AND z.dat_bis
   INNER JOIN dbp_view.v_art_wup_ek_zu_per_2 t04
   ON  v01.mandant_id  = t04.mandant_id
   AND v01.art_id      = t04.art_id
   AND v01.dat BETWEEN t04.dat_von AND t04.dat_bis
   AND t04.wup_id      = -1
   WHERE v01.mandant_id <>1;