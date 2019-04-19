close all;
clear all;
c=clock; fprintf('RUN STARTED >>>>  Date: %d/%d/%d Time: %d:%d:%2.2f.\n',c(2),c(3),c(1),c(4),c(5),c(6));

no_of_points=15;

raw_data=dlmread('Well_Log_Example.prn');
data(:,1)=raw_data(:,1);
data(:,2)=raw_data(:,3);


original_data=data;
original_size_data=size(data,1);

for j=1:original_size_data-no_of_points
    area=[];
    interpolated_dist=[];
    obj_func=[];
    a=original_size_data-no_of_points
    x=data(:,1);
    y=data(:,2);
    for i=2:size(x,1)-1;
        xv=[x(i-1) x(i) x(i+1)];
        yv=[y(i-1) y(i) y(i+1)];
        area(i-1,1)=polyarea(xv,yv);
    end;
    obj_func=area;
    [minValue, rowsToDelete1] = min(obj_func(:,1));
    history_obj_func(j,1:2)=[original_size_data-j minValue];
    data(rowsToDelete1+1, :) = [];  % Get rid of min.
end;

figure;
plot(original_data(:,2),original_data(:,1),'b-');
hold on;
plot(data(:,2),data(:,1),'r:','LineWidth',2);
hold on;
plot(data(:,2),data(:,1),'ro','LineWidth',2);
set(gca,'YDir','Reverse');
ylabel('Depth (ft)','FontName','Times New Roman','FontSize',14.0);
xlabel('VP (ft/sec)','FontName','Times New Roman','FontSize',14.0);
grid on;


figure;
plot(history_obj_func(:,1), history_obj_func(:,2),'b-','LineWidth',2);
ylabel('Error','FontName','Times New Roman','FontSize',14.0);
xlabel('Number of control points/knots','FontName','Times New Roman','FontSize',14.0);
grid on;