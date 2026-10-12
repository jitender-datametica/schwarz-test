/*
###########################################################################
#  1.) Erstellen Hilfstabelle ma_denorm für VAUS
###########################################################################
*/


	
DROP TABLE IF EXISTS ${KFL_SNFLK_COMMON_DBP_LOAD}.ma_denorm;	

CREATE OR REPLACE TABLE ${KFL_SNFLK_COMMON_DBP_LOAD}.ma_denorm
     (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      glv_land_id INTEGER NOT NULL,
      stv_glv_land_id INTEGER NOT NULL,
      gl_vertrieb_id INTEGER NOT NULL,
      gf_gbl_vertrieb_id INTEGER NOT NULL,
      vkl_id INTEGER NOT NULL,
      hausleiter_id INTEGER NOT NULL,
      wbl_food_id INTEGER NOT NULL,
      wbl_frische_id INTEGER NOT NULL,
      wbl_nonfood_id INTEGER NOT NULL,
      wbl_kasse_id INTEGER NOT NULL,
      frische_manager_id INTEGER NOT NULL,
      regionale_psb_id INTEGER NOT NULL,
td_insert DATE,
td_update DATE,
      constraint UPI_wup_denorm UNIQUE ( mandant_id ,wup_id )
      );


/*
###########################################################################
#  1.) Erstellen Hilfstabelle ma_denorm_per für VAUS
###########################################################################
*/


CREATE TABLE IF NOT EXISTS ${KFL_SNFLK_COMMON_DBP_LOAD}.ma_denorm_per 
     (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      dat_von DATE NOT NULL,
      gl_vertrieb_id INTEGER NOT NULL,
      gf_gbl_vertrieb_id INTEGER NOT NULL,
      vkl_id INTEGER NOT NULL,
      frische_manager_id INTEGER NOT NULL,
      dat_bis DATE NOT NULL DEFAULT date '9999-12-31',
td_insert DATE,
td_update DATE,
      constraint UPI_wup_denorm UNIQUE ( mandant_id ,wup_id,dat_von )
      );
