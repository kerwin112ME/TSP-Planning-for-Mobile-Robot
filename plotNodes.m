function plotNodes(nodes)
    s = size(nodes);
    for i = 1:s(2)
        scatter(nodes{i}.x,nodes{i}.y,45,'o','r','LineWidth',3);
        text(nodes{i}.x,nodes{i}.y,int2str(i),'VerticalAlignment','top');
        hold on
    end
    axis([0,100,0,100]);
    title('nodes','fontsize',14)
 
end
