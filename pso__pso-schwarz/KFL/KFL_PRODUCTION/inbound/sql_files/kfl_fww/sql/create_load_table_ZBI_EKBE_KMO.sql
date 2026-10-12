/*
###########################################################################
#    Erstellen Hilfstabelle de_mseg 
###########################################################################
*/

CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.kmo_ekbe
(
        mandant_id BYTEINT NOT NULL,
        best_beleg_pos_id INTEGER,
        best_beleg_id DECIMAL(18,0) ,
        kontierung_pos_id BYTEINT,
        vorgart_best_entw_id CHAR(1) ,
        folge_beleg_id DECIMAL(18,0) ,
        folge_beleg_pos_id INTEGER,
        kj SMALLINT,
        wup_id INTEGER,
        nb_id SMALLINT,
        bestaetigung_lfd_nr SMALLINT ,
        best_entw_typ_id CHAR(1) ,
        menge_anteil DECIMAL(18,3),
        menge_best DECIMAL(18,3),
        lager_bewart_id CHAR(3) ,
        dat_buch DATE ,
        menge_basis DECIMAL(18,3),
        betrag DECIMAL(18,4),
        wrg_id CHAR(3)  ,
        soll_haben_kz CHAR(1) ,
        ref_beleg_id DECIMAL(18,0),
        ref_beleg_pos_id INTEGER,
        ref_gj SMALLINT ,
        system_id SMALLINT,
        betrag_wrbtr DECIMAL(18,4),
        wrg_id_beleg CHAR(3) ,
        dat_buch_orig DATE  ,
        cpudt      VARCHAR(16) ,
        bldat      VARCHAR(16) ,
        cputm      VARCHAR(30) ,
TD_UPDATE TIMESTAMP_LTZ(9),
TD_INSERT TIMESTAMP_LTZ(9));
