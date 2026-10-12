CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BEST_BELEGFLUSS_BNK
    (
    mandant_id
    , best_beleg_id
    , best_beleg_pos_id
    , anzahlpositionen
    , folge_beleg_id
    , folge_beleg_pos_id
    , kj
    , kond_stufe_id
    , kond_zaehl_id
    , vorgart_best_entw_id
    , best_entw_typ_id
    , betrag_kondition
    , soll_haben_kz
    , ref_lagerbew_beleg_id
    , gp_id
    , dat_erfasst
    , dat_buch
    , system_id
    , konditionsart_id
    , wrg_id
    )
    AS
       SELECT
       v01.mandant_id,
       v01.best_beleg_id,
       v01.best_beleg_pos_id,
       1 AS anzahlpositionen,
       v01.folge_beleg_id,
       v01.folge_beleg_pos_id,
       v01.kj,
       v01.kond_stufe_id,
       v01.kond_zaehl_id,
       v01.vorgart_best_entw_id,
       v01.best_entw_typ_id,
       v01.betrag_kondition,
       v01.soll_haben_kz,
       v01.ref_lagerbew_beleg_id,
       v01.gp_id,
       v01.dat_erfasst,
       v01.dat_buch,
       7,
       v01.konditionsart_id,
       v01.wrg_id

FROM dbp_view.v_best_belegfluss_bnk v01
       WHERE mandant_id = 1;