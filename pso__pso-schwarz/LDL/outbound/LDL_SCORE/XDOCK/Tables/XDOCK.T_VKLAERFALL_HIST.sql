CREATE TABLE IF NOT EXISTS ldl_score_xdock.t_vklaerfall_hist (
klaerfallid BIGNUMERIC(38,0),
lagerid BIGNUMERIC(38,0),
klaerfalltyp BIGNUMERIC(38,0),
wetourid BIGNUMERIC(38,0),
watourid BIGNUMERIC(38,0),
paletteid BIGNUMERIC(38,0),
createdat DATETIME,
finishedat DATETIME,
correctedat DATETIME,
createdbyidnew BIGNUMERIC(38,0),
finishedbyidnew BIGNUMERIC(38,0),
correctedbyidnew BIGNUMERIC(38,0),
klaerfallresolution BIGNUMERIC(38,0),
datum DATE,
dwh_created_tmsp DATETIME,
dwh_updated_tmsp DATETIME
);