
close all;clear all;clc;

%% load lat and longs for each site
CB_latLongs = [58.645683,-148.07; %01
58.671333,-148.02; %02
58.673483,-148.00; %03
58.671867,-148.02; %04
58.671,-148.02; %05
58.670817,-148.02; %06
58.65525,-148.09; %07
58.6695,-148.03; %08
58.6695,-148.0338889; %09
58.66961667,-148.03]; %10

QN_latLongs = [56.339017,-145.18; %01
56.339383,-145.18; %02
56.3413,-145.18; %04
56.340683,-145.18; %05
56.339833,-145.19]; %06

PT_latLongs = [56.24345, -142.75; %01
56.243917, -142.75; %02
56.242917, -142.75; %03
56.243333, -142.75]; %04

OCNMSQC_latLongs = [47.466,-125.16; %6
47.50005,-125.36; %12
47.500433,-125.36; %14
47.500533,-125.36; %15
47.500633,-125.65]; %16

ALEUTBD_latLongs = [52.633333,-175.63; %02
52.076,-175.64]; %03

SAIPAN_latLongs = [15.31663333, 145.46; %1
15.3171, 145.46; %2
15.31778333, 145.46; %3
15.32125, 145.46; %4
15.32125, 145.46; %5
15.31743333, 145.46]; %6
%missing 7]; %7

TIN_latLongs = [15.03906667, 145.75; %2
15.0398, 145.75; %3
15.03735, 145.75; %4
15.03735, 145.75; %5
15.04003333, 145.75]; %6
%missing 7]; %7

Wake_latLongs = [19.22, -166.69; %1
19.2209, -166.69; %3
19.22156667, -166.69; %4
19.22216667, -166.69; %5
19.22346667, -166.69; %6
19.37206667, -166.69]; %7

%% load lat and long with only 1 deployment
GI_mean = [29.14103333, -118.26]; %1
GItext = repmat({'GI'},size(GI_mean,1),1);
GI = [GItext num2cell(GI_mean)];

CORC_mean = [31.747,-121.38]; 
CORCtext = repmat({'CORC'},size(CORC_mean,1),1);
CORC = [CORCtext num2cell(CORC_mean)];

%find means of sites with multiple deployments
[CBlat,CBlong] = meanm(CB_latLongs(:,1),CB_latLongs(:,2));
CB_mean = [CBlat,CBlong];
CBtext = repmat({'CB'},size(CB_mean,1),1);
CB = [CBtext num2cell(CB_mean)];

[QNlat,QNlong] = meanm(QN_latLongs(:,1),QN_latLongs(:,2));
QN_mean = [QNlat, QNlong];
QNtext = repmat({'QN'},size(QN_mean,1),1);
QN = [QNtext num2cell(QN_mean)];

[PTlat,PTlong] = meanm(PT_latLongs(:,1),PT_latLongs(:,2));
PT_mean = [PTlat, PTlong];
PTtext = repmat({'PT'},size(PT_mean,1),1);
PT = [PTtext num2cell(PT_mean)];

[QClat,QClong] = meanm(OCNMSQC_latLongs(:,1),OCNMSQC_latLongs(:,2));
OCNMSQC_mean = [QClat, QClong];
OCNMStext = repmat({'OCNMS'},size(OCNMSQC_mean,1),1);
OCNMS = [OCNMStext num2cell(OCNMSQC_mean)];

[BDlat, BDlong] = meanm(ALEUTBD_latLongs(:,1),ALEUTBD_latLongs(:,2));
ALEUTBD_mean = [BDlat, BDlong];
BDtext = repmat({'BD'},size(ALEUTBD_mean,1),1);
BD = [BDtext num2cell(ALEUTBD_mean)];

[SAIPANlat, SAIPANlong] = meanm(SAIPAN_latLongs(:,1),SAIPAN_latLongs(:,2));
SAIPAN_mean = [SAIPANlat, SAIPANlong];
SAIPANtext = repmat({'Saipan'},size(SAIPAN_mean,1),1);
SAIPAN = [SAIPANtext num2cell(SAIPAN_mean)];

[TINlat, TINlong] = meanm(TIN_latLongs(:,1),TIN_latLongs(:,2));
TIN_mean = [TINlat, TINlong];
TINtext = repmat({'Tinian'},size(TIN_mean,1),1);
TIN = [TINtext num2cell(TIN_mean)];

[Wakelat, Wakelong] = meanm(Wake_latLongs(:,1),Wake_latLongs(:,2));
Wake_mean = [Wakelat, Wakelong];
Waketext = repmat({'Wake'},size(Wake_mean,1),1);
Wake = [Waketext num2cell(Wake_mean)];

[QClat,QClong] = meanm(OCNMSQC_latLongs(:,1),OCNMSQC_latLongs(:,2));
OCNMSQC_mean = [QClat, QClong];
OCNMStext = repmat({'OCNMS'},size(OCNMSQC_mean,1),1);
OCNMS = [OCNMStext num2cell(OCNMSQC_mean)];

%% create one table with all lat and longs
LL = [BD; CB; CORC; OCNMS; PT; QN; SAIPAN; TIN; Wake; GI];
LatLong = cell2mat(LL(:,2:3));

LatLongTAB = array2table(LatLong);
LatLongTAB.Properties.VariableNames = {'Latitude' 'Longitude'};

LatLongTAB{:,'Site'} = {'BD'; 'CB'; 'CORC'; 'OCNMS'; 'PT'; 'QN'; 'SAIPAN'; 'TIN'; 'Wake'; 'GI'};

LatLongTAB.Longitude(41) = -2.154600000000000e+02; %Saipan
LatLongTAB.Longitude(42) = -2.157500000000000e+02; %Tinian
%% grey site map
figure(3)
LatLongTAB.Site = categorical(LatLongTAB.Site);
A = 200;
latitude = LatLongTAB.Latitude;
longitude = LatLongTAB.Longitude;
gm = geoscatter(latitude,longitude,A,'.','k');  
text(latitude(1),longitude(1)-0.5,'AB','HorizontalAlignment','right','FontSize',16);
text(latitude(2)-1,longitude(2)+4,'BC','HorizontalAlignment','right','FontSize',16);
text(latitude(3),longitude(3)+5,'BD','HorizontalAlignment','right','FontSize',16);
text(latitude(4),longitude(4)-0.5,'BP','HorizontalAlignment','right','FontSize',16);
text(latitude(5),longitude(5)+5,'BS','HorizontalAlignment','right','FontSize',16);
text(latitude(6),longitude(6)-0.5,'CB','HorizontalAlignment','right','FontSize',16);
text(latitude(7),longitude(7)-0.5,'CCE','HorizontalAlignment','right','FontSize',16);
text(latitude(8),longitude(8)+10,'CORC','HorizontalAlignment','right','FontSize',16);
text(latitude(9),longitude(9)-0.5,'CSM','HorizontalAlignment','right','FontSize',16);
text(latitude(10),longitude(10)-0.5,'DCPP','HorizontalAlignment','right','FontSize',16);
text(latitude(11),longitude(11)-0.5,'DT','HorizontalAlignment','right','FontSize',16);
text(latitude(12),longitude(12)-0.5,'EQ','HorizontalAlignment','right','FontSize',16);
text(latitude(13),longitude(13)-0.5,'GC','HorizontalAlignment','right','FontSize',16);
%text(latitude(14),longitude(14)-0.5,'GCAB','HorizontalAlignment','right','FontSize',16);
text(latitude(15),longitude(15)-0.5,'GCAPP','HorizontalAlignment','right','FontSize',16);
text(latitude(16)-1,longitude(16)-0.5,'GCAT','HorizontalAlignment','right','FontSize',16);
text(latitude(17),longitude(17)-0.5,'GS','HorizontalAlignment','right','FontSize',16);
text(latitude(18),longitude(18)-0.5,'HAT','HorizontalAlignment','right','FontSize',16);
text(latitude(20),longitude(20)+8,'HAW','HorizontalAlignment','right','FontSize',16);
text(latitude(21)-1.5,longitude(21)-0.5,'HOKE','HorizontalAlignment','right','FontSize',16);
text(latitude(22)+0.5,longitude(22)-0.5,'HZ','HorizontalAlignment','right','FontSize',16);
text(latitude(23),longitude(23)-0.5,'JAX','HorizontalAlignment','right','FontSize',16);
text(latitude(27),longitude(27)-0.5,'KAU','HorizontalAlignment','right','FontSize',16);
text(latitude(28)+1,longitude(28)+6.5,'KOA','HorizontalAlignment','right','FontSize',16);
text(latitude(29),longitude(29)-0.5,'KS','HorizontalAlignment','right','FontSize',16);
text(latitude(30),longitude(30)-0.5,'LSM','HorizontalAlignment','right','FontSize',16);
text(latitude(31)+0.5,longitude(31)-0.5,'MC','HorizontalAlignment','right','FontSize',16);
text(latitude(32)+0.5,longitude(32)-0.5,'NC','HorizontalAlignment','right','FontSize',16);
text(latitude(33),longitude(33)-0.5,'NFC','HorizontalAlignment','right','FontSize',16);
text(latitude(34)-1,longitude(34)+4.5,'OC','HorizontalAlignment','right','FontSize',16);
text(latitude(35),longitude(35)-0.5,'QC','HorizontalAlignment','right','FontSize',16);
text(latitude(36),longitude(36)-0.5,'PAL','HorizontalAlignment','right','FontSize',16);
text(latitude(38),longitude(38)+7,'PHR','HorizontalAlignment','right','FontSize',16);
text(latitude(39),longitude(39)+4.5,'PT','HorizontalAlignment','right','FontSize',16);
text(latitude(40),longitude(40)-0.5,'QN','HorizontalAlignment','right','FontSize',16);
text(latitude(41)+2,longitude(41)-0.5,'SAI','HorizontalAlignment','right','FontSize',16);
text(latitude(42),longitude(42)+6,'TIN','HorizontalAlignment','right','FontSize',16);
text(latitude(43),longitude(43)-0.5,'WAK','HorizontalAlignment','right','FontSize',16);
text(latitude(44)+0.5,longitude(44)-1,'WC','HorizontalAlignment','right','FontSize',16);
text(latitude(45)+0.5,longitude(45)+5,'KR','HorizontalAlignment','right','FontSize',16);
text(latitude(46),longitude(46)-0.5,'PI','HorizontalAlignment','right','FontSize',16);
text(latitude(47),longitude(47)-0.5,'GI','HorizontalAlignment','right','FontSize',16);
geolimits([-3 74],[-180 -110]);
set(gcf,'Color','w');
save('Site_map.png');
export_fig Site_mapHQ.png