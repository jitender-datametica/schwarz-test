CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_wewa_wwc_2 (mandant_id, wewa_beleg_id, wewa_beleg_pos_id,
wewa_jahr, art_id, wup_id, nb_id, gp_id, lager_bewart_id, dat_buch, menge_basis, wewa_status, vorzeichen_rseg,
vorzeichen, ek_mep, ek_mep_olk, wewa_menge_zl_we, wewa_menge_zl_re, betrag_ekn_zl_we, betrag_ekn_zl_re,
wewa_menge_ret_zl_we, wewa_menge_ret_zl_re, betrag_ekn_ret_zl_we, betrag_ekn_ret_zl_re, wewa_menge_inkl_ret_zl_we,
wewa_menge_inkl_ret_zl_re, betrag_ekn_inkl_ret_zl_we, betrag_ekn_inkl_ret_zl_re, wewa_menge_dz_we, wewa_menge_dz_re,
betrag_ekn_dz_we, betrag_ekn_dz_re, wewa_menge_ret_dz_we, wewa_menge_ret_dz_re, betrag_ekn_ret_dz_we,
betrag_ekn_ret_dz_re, wewa_menge_inkl_ret_dz_we, wewa_menge_inkl_ret_dz_re, betrag_ekn_inkl_ret_dz_we,
betrag_ekn_inkl_ret_dz_re, wewa_menge_we, wewa_menge_re, betrag_ekn_we, betrag_ekn_re, wewa_menge_ret_we,
wewa_menge_ret_re, betrag_ekn_ret_we, betrag_ekn_ret_re, wewa_menge_inkl_ret_we, wewa_menge_inkl_ret_re,
betrag_ekn_inkl_ret_we, betrag_ekn_inkl_ret_re, wrg_id, posten_kz_per) AS SELECT V01.ekbe_mandant_id AS mandant_id,
 V01.mseg_beleg_id AS wewa_beleg_id,
 V01.mseg_beleg_pos_id AS wewa_beleg_pos_id,
 V01.mseg_kj AS wewa_jahr,
 V01.ekpo_art_id AS art_id,
 V01.ekbe_wup_id AS wup_id,
 V01.ekbe_nb_id AS nb_id,
 V01.mseg_gp_id AS gp_id,
 V01.mseg_lager_bewart_id AS lager_bewart_id,
 V01.mkpf_dat_buch AS dat_buch,
 V01.mseg_menge_bestand_bme AS menge_basis,
 V01.rbkp_belegart_id AS wewa_status,
  CASE
  WHEN V01.rseg_soll_haben_kz = 'H'
  THEN - 1
  ELSE 1
  END AS vorzeichen_rseg,
  CASE
  WHEN V01.ekbe_soll_haben_kz = 'H'
  THEN - 1
  ELSE 1
  END AS vorzeichen,
 SUM(CASE
   WHEN V01.ekbe_mandant_id = 1
   THEN 0
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_mep, v03.ek_mep)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(v02.ek_mep, v03.ek_mep) * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(v02.ek_mep, v03.ek_mep) * V400.umrechnungskurs
   ELSE NULL
   END) AS ek_mep,
 SUM(CASE
   WHEN V01.ekbe_mandant_id = 1
   THEN 0
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(v02.ek_mep, v03.ek_mep) - COALESCE(v02.logistikkostenzuschlag, v03.logistikkostenzuschlag)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN (COALESCE(v02.ek_mep, v03.ek_mep) - COALESCE(v02.logistikkostenzuschlag, v03.logistikkostenzuschlag)) * V300.umrechnungskurs
    
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN (COALESCE(v02.ek_mep, v03.ek_mep) - COALESCE(v02.logistikkostenzuschlag, v03.logistikkostenzuschlag)) * V400.umrechnungskurs
    
   ELSE NULL
   END) AS ek_mep_olk,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     
   THEN V01.ekbe_menge_best
   ELSE 0
   END) AS wewa_menge_zl_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     
   THEN CASE
    WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
    THEN 0
    ELSE V01.ekbe_menge_best_rech
    END
   ELSE 0
   END) AS wewa_menge_zl_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
     WHEN V01.ekbe_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_zl_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
     WHEN V01.rseg_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_zl_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     
   THEN V01.ekbe_menge_best
   ELSE 0
   END) AS wewa_menge_ret_zl_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     
   THEN CASE
    WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
    THEN 0
    ELSE V01.ekbe_menge_best_rech
    END
   ELSE 0
   END) AS wewa_menge_ret_zl_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
     WHEN V01.ekbe_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_ret_zl_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
     WHEN V01.rseg_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_ret_zl_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
      111
    THEN V01.ekbe_menge_best
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_menge_best
    ELSE 0
    END) AS wewa_menge_inkl_ret_zl_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
      111
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) AS wewa_menge_inkl_ret_zl_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = - 111
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_inkl_ret_zl_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = - 111
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_inkl_ret_zl_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_menge_best
   ELSE 0
   END) AS wewa_menge_dz_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN CASE
    WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
    THEN 0
    ELSE V01.ekbe_menge_best_rech
    END
   ELSE 0
   END) AS wewa_menge_dz_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag * CASE
     WHEN V01.ekbe_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_dz_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
     WHEN V01.rseg_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_dz_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_menge_best
   ELSE 0
   END) AS wewa_menge_ret_dz_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN CASE
    WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
    THEN 0
    ELSE V01.ekbe_menge_best_rech
    END
   ELSE 0
   END) AS wewa_menge_ret_dz_re,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
      = 0
   THEN V01.ekbe_betrag * CASE
     WHEN V01.ekbe_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('161', '162') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('161', '162') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_ret_dz_we,
 SUM(CASE
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
    AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
     WHEN V01.rseg_soll_haben_kz = 'H'
     THEN - 1
     ELSE 1
     END
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V300.umrechnungskurs
   WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
      IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
   THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END * V400.umrechnungskurs
   ELSE 0
   END) AS betrag_ekn_ret_dz_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_menge_best
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_menge_best
    ELSE 0
    END) AS wewa_menge_inkl_ret_dz_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) AS wewa_menge_inkl_ret_dz_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = 0
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_inkl_ret_dz_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = 0
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_inkl_ret_dz_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
      111
    THEN V01.ekbe_menge_best
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_menge_best
    ELSE 0
    END) AS wewa_menge_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
      111
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) AS wewa_menge_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
     AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_menge_best
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_menge_best
    ELSE 0
    END) AS wewa_menge_ret_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN CASE
     WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
     THEN 0
     ELSE V01.ekbe_menge_best_rech
     END
    ELSE 0
    END) AS wewa_menge_ret_re,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = - 111
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = 0
    THEN V01.ekbe_betrag * CASE
      WHEN V01.ekbe_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_ret_we,
  SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = - 111
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = - 111
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) + SUM(CASE
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
       = 0
    THEN V01.ekbe_betrag_rech * CASE
      WHEN V01.rseg_soll_haben_kz = 'H'
      THEN - 1
      ELSE 1
      END
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V300.umrechnungskurs
    WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
       IN ('161', '162') AND V01.ekbe_nb_id = 0
    THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END * V400.umrechnungskurs
    ELSE 0
    END) AS betrag_ekn_ret_re,
   SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
       111
     THEN V01.ekbe_menge_best
     ELSE 0
     END) + SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_menge_best
     ELSE 0
     END) + (SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_menge_best
      ELSE 0
      END) + SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_menge_best
      ELSE 0
      END)) AS wewa_menge_inkl_ret_we,
   SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = -
       111
     THEN CASE
      WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
      THEN 0
      ELSE V01.ekbe_menge_best_rech
      END
     ELSE 0
     END) + SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN CASE
      WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
      THEN 0
      ELSE V01.ekbe_menge_best_rech
      END
     ELSE 0
     END) + (SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN CASE
       WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
       THEN 0
       ELSE V01.ekbe_menge_best_rech
       END
      ELSE 0
      END) + SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN CASE
       WHEN V01.ekbe_best_entw_typ_id_rech = 'N'
       THEN 0
       ELSE V01.ekbe_menge_best_rech
       END
      ELSE 0
      END)) AS wewa_menge_inkl_ret_re,
   SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
      AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
         IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V300.umrechnungskurs
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
         IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V400.umrechnungskurs
     ELSE 0
     END) + SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
        = - 111
     THEN V01.ekbe_betrag * CASE
       WHEN V01.ekbe_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
         IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V300.umrechnungskurs
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
         IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V400.umrechnungskurs
     ELSE 0
     END) + (SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902'
          ) AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
          IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag * CASE
         WHEN V01.ekbe_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V300.umrechnungskurs
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
          IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag * CASE
         WHEN V01.ekbe_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V400.umrechnungskurs
      ELSE 0
      END) + SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
         = 0
      THEN V01.ekbe_betrag * CASE
        WHEN V01.ekbe_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
          IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag * CASE
         WHEN V01.ekbe_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V300.umrechnungskurs
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
          IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag * CASE
         WHEN V01.ekbe_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V400.umrechnungskurs
      ELSE 0
      END)) AS betrag_ekn_inkl_ret_we,
   SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902')
      AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
         IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V300.umrechnungskurs
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
         IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V400.umrechnungskurs
     ELSE 0
     END) + SUM(CASE
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
        = - 111
     THEN V01.ekbe_betrag_rech * CASE
       WHEN V01.rseg_soll_haben_kz = 'H'
       THEN - 1
       ELSE 1
       END
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
         IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V300.umrechnungskurs
     WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
         IN ('161', '162') AND V01.ekbe_nb_id = - 111
     THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END * V400.umrechnungskurs
     ELSE 0
     END) + (SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('101', '102', '901', '902'
          ) AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
          IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag_rech * CASE
         WHEN V01.rseg_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V300.umrechnungskurs
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
          IN ('101', '102', '901', '902') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag_rech * CASE
         WHEN V01.rseg_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V400.umrechnungskurs
      ELSE 0
      END) + SUM(CASE
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 1 AND V01.mseg_lager_bewart_id IN ('161', '162') AND V01.ekbe_nb_id
         = 0
      THEN V01.ekbe_betrag_rech * CASE
        WHEN V01.rseg_soll_haben_kz = 'H'
        THEN - 1
        ELSE 1
        END
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0 AND V01.mseg_lager_bewart_id
          IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag_rech * CASE
         WHEN V01.rseg_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V300.umrechnungskurs
      WHEN V01.ekbe_mandant_id <> 1 AND V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1 AND V01.mseg_lager_bewart_id
          IN ('161', '162') AND V01.ekbe_nb_id = 0
      THEN V01.ekbe_betrag_rech * CASE
         WHEN V01.rseg_soll_haben_kz = 'H'
         THEN - 1
         ELSE 1
         END * V400.umrechnungskurs
      ELSE 0
      END)) AS betrag_ekn_inkl_ret_re,
 V01.mseg_wrg_id AS wrg_id,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_wewa_wwc_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_nettonetto,
   ek_brutto,
   ek_brutto_normal,
   ek_mep,
   logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
  WHERE mandant_id <> 1
   AND wup_id > - 1) AS v02 ON V01.ekbe_mandant_id = v02.mandant_id AND V01.ekbe_wup_id = v02.wup_id AND V01.mseg_gp_id
     = v02.gp_id AND V01.ekpo_art_id = v02.art_id AND V01.mkpf_dat_buch BETWEEN v02.dat_von AND v02.dat_bis
 LEFT JOIN (SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_nettonetto,
   ek_brutto,
   ek_brutto_normal,
   ek_mep,
   logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
  WHERE mandant_id <> 1
   AND wup_id = - 1) AS v03 ON V01.ekbe_mandant_id = v03.mandant_id AND V01.mseg_gp_id = v03.gp_id AND V01.ekpo_art_id =
    v03.art_id AND V01.mkpf_dat_buch BETWEEN v03.dat_von AND v03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V01.mseg_wrg_id = V300.von_wrg_id
      AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V400 ON V01.mkpf_dat_buch BETWEEN V400.dat_von AND V400.dat_bis AND V01.mseg_wrg_id
      = V400.von_wrg_id AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR'
 LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS V04 ON V01.ekpo_art_id = V04.art_id AND V01.ekbe_mandant_id = V04.mandant_id
     AND V01.mkpf_dat_buch BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
GROUP BY mandant_id,
 wewa_beleg_id,
 wewa_beleg_pos_id,
 wewa_jahr,
 art_id,
 wup_id,
 nb_id,
 gp_id,
 lager_bewart_id,
 dat_buch,
 menge_basis,
 wewa_status,
 vorzeichen_rseg,
 vorzeichen,
 wrg_id,
 posten_kz_per;