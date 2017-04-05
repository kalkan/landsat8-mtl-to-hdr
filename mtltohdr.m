function mtltohdr(MTL_filename)
[pathstr,name,~] = fileparts(MTL_filename);
mtl = MTLParser(MTL_filename);

samples = mtl.PRODUCT_METADATA.REFLECTIVE_SAMPLES;
lines   = mtl.PRODUCT_METADATA.REFLECTIVE_LINES;
bands   = 7;
acquisition_date = mtl.PRODUCT_METADATA.DATE_ACQUIRED;
% acquisition_hour = mtl.PRODUCT_METADATA.SCENE_CENTER_TIME;
utm_zone = mtl.PROJECTION_PARAMETERS.UTM_ZONE;

newHdrFile = [pathstr '\' name(1:end-4) '.hdr'];
writeID = fopen(newHdrFile, 'w');
fprintf(writeID, '%s\r\n', 'ENVI');
fprintf(writeID,'%s\r\n',['samples = ' num2str(samples)]);
fprintf(writeID,'%s\r\n',['lines = ' num2str(lines)]);
fprintf(writeID,'%s\r\n',['bands = ' num2str(bands)]);
fprintf(writeID,'%s\r\n',['datatype = 2']);
fprintf(writeID,'%s\r\n',['interleave = bip']);
fprintf(writeID,'%s\r\n',['map info = {UTM, 1.000, 1.000,' num2str(mtl.PRODUCT_METADATA.CORNER_UL_PROJECTION_X_PRODUCT) ',' num2str(mtl.PRODUCT_METADATA.CORNER_UL_PROJECTION_Y_PRODUCT) ', 3.000000e+001, 3.000000e+001, ' num2str(utm_zone) ', North, WGS-84, units=Meters}']);
fprintf(writeID,'%s\r\n',['coordinate system string = {PROJCS["WGS_1984_UTM_Zone_' num2str(utm_zone) 'N",GEOGCS["GCS_WGS_1984",DATUM["D_WGS_1984",SPHEROID["WGS_1984",6378137.0,298.257223563]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Transverse_Mercator"],PARAMETER["False_Easting",500000.0],PARAMETER["False_Northing",0.0],PARAMETER["Central_Meridian",39.0],PARAMETER["Scale_Factor",0.9996],PARAMETER["Latitude_Of_Origin",0.0],UNIT["Meter",1.0]]}']);
fprintf(writeID,'%s\r\n',['default bands = {4,3,2}']);
fprintf(writeID,'%s\r\n',['wavelength = {440.000000,  470.000000,  560.000000,  655.000000,  865.000000, 1610.000000, 2200.000000}']);
fprintf(writeID,'%s\r\n',['sensor type = Landsat-8 OLI']);
fprintf(writeID,'%s\r\n',['acquisition time = ' acquisition_date]);

fclose(writeID);
end



