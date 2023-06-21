a=0.4;
l=0.4;
%单位：米
u=linspace(0,pi,20);
rx=[];
ry=[];
theta=[];
for i=1:20
    rx(end+1)=-2*a*( ( l-cos(u(i)) ) * cos(u(i)) + (1-l) );
    ry(end+1)=2*a*(l-cos(u(i)))*sin(u(i));
end
plot(rx,ry)

%X,Y对u的一阶导数
X_1=[];
Y_1=[];
X_1=diff(rx)./diff(u);
Y_1=diff(ry)./diff(u);
%计算T
T_X=[];
T_Y=[];
for i=1:19
    dis=sqrt(X_1(i)*X_1(i)+Y_1(i)*Y_1(i));
    T_X(end+1)=X_1(i)/dis;
    T_Y(end+1)=Y_1(i)/dis;
end

T_X1=diff(T_X)./diff(u(1:end-1));
T_Y1=diff(T_Y)./diff(u(1:end-1));

k=[];
for i=1:18
    disT=sqrt(T_X1(i)*T_X1(i)+T_Y1(i)*T_Y1(i));
    disR=sqrt(X_1(i)*X_1(i)+Y_1(i)*Y_1(i));
    k(end+1)=disT/disR;
end
k=[1.0./k];

rx1=diff(rx)./diff(u);
ry1=diff(ry)./diff(u);
%将轨迹切成一段一段的直线：
for i=2:19
    clf;
    hold on;
    axis equal;
    plot(rx,ry)
    dx1=rx(i+1)-rx(i);
    dy1=ry(i+1)-ry(i);
    
    dx2=rx(i)-rx(i-1);
    dy2=ry(i)-ry(i-1);
    
    quiver(rx(i),ry(i),dx1,dy1,'Color',[1.0,0.0,0.0],'LineWidth',3.0);
 
    theta(end+1)=judge(dx2,dy2,dx1,dy1);
    theta(end)
    legend('路径','直线运动的方向');
    drawnow
end
    L=[];
    tot=0;
for i=1:19
    dx=rx(i+1)-rx(i);
    dy=ry(i+1)-ry(i);
    L(end+1)=sqrt(dx*dx+dy*dy);
    tot=tot+L(end);
end


function theta=judge(x1,y1,x2,y2)
    len1=sqrt(x1*x1+y1*y1);
    len2=sqrt(x2*x2+y2*y2);
    dc=x1*x2+y1*y2;
    theta=acos(dc/(len1*len2));
end
