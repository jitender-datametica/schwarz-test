/*
###########################################################################
#  clone data from KFL_PRODUCTION
###########################################################################
*/
DELETE FROM dbp_data.art_gp_zu_per_2;

INSERT INTO dbp_data.art_gp_zu_per_2 SELECT * FROM KFL_PRODUCTION.dbp_data.art_gp_zu_per_2;
