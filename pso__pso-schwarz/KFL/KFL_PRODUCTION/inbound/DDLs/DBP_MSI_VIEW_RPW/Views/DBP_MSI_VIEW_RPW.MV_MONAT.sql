CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_MONAT
 (
 kjmo
 ,kjmo_vj
 ,gjmo
 ,gjmo_vj
 ,kjqu
 ,gjqu
 ,kj
 ,gj
 ,akt_mo
 ,akt_mo_komplett
 ,akt_gjqu
 ,akt_gjqu_komplett
 ,akt_kjqu
 ,akt_kjqu_komplett
 ,akt_gj
 ,akt_gj_komplett
 ,akt_kj
 ,akt_kj_komplett
 ,mo_gj
 ,mo_kj
 ,kjmo_dat_von
 ,kjmo_dat_bis
 ,system_id
 )
 AS
    SELECT
    m.kjmo, m.kjmo_vj, m.gjmo, m.gjmo_vj, m.kjqu, m.gjqu, m.kj, m.gj, m.akt_mo, m.akt_mo_komplett, m.akt_gjqu, m.akt_gjqu_komplett, m.akt_kjqu, m.akt_kjqu_komplett, m.akt_gj, m.akt_gj_komplett, m.akt_kj, m.akt_kj_komplett, m.mo_gj, m.mo_kj, MIN(t.dat) AS kjmo_dat_von, MAX(t.dat) AS kjmo_dat_bis, 7
    FROM dbp_view.v_monat m
    INNER JOIN dbp_view.v_tag t
    ON m.kjmo = t.kjmo

    WHERE m.kjmo >= 200501
    AND m.kj <= EXTRACT(YEAR FROM CURRENT_DATE)
    
        GROUP BY
    m.kjmo
    ,m.kjmo_vj
    ,m.gjmo
    ,m.gjmo_vj
    ,m.kjqu
    ,m.gjqu
    ,m.kj
    ,m.gj
    ,m.akt_mo
    ,m.akt_mo_komplett
    ,m.akt_gjqu
    ,m.akt_gjqu_komplett
    ,m.akt_kjqu
    ,m.akt_kjqu_komplett
    ,m.akt_gj
    ,m.akt_gj_komplett
    ,m.akt_kj
    ,m.akt_kj_komplett
    ,m.mo_gj
    ,m.mo_kj ;