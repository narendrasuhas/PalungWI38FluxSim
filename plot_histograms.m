%%
clf; clc;
rxns = {'CI_MitoCore','O2tm','CII_MitoCore','CIII_MitoCore'};
num_rxns = length(rxns);
f_alpha = 0.4;

fig_id = 1;
for i = 1:num_rxns
    b_id = findRxnIDs(b_model,rxns(i));
    h_id = findRxnIDs(h_model,rxns(i));

    subplot(num_rxns,2,fig_id);
    histogram(sample_bat_ctrl(b_id,:),'FaceColor','b','FaceAlpha',f_alpha);
    hold on;
    histogram(sample_human_ctrl(h_id,:),'FaceColor','r','FaceAlpha',f_alpha);
    legend({'P','W'},'Location','best');
    fig_id = fig_id+1;
    title([strrep(rxns{i},'_','-'),' - Control']);
    xlabel('Reaction flux');    

    subplot(num_rxns,2,fig_id);
    histogram(sample_bat_constr(b_id,:),'FaceColor','b','FaceAlpha',f_alpha);
    hold on;
    histogram(sample_human_constr(h_id,:),'FaceColor','r','FaceAlpha',f_alpha);
    legend({'P','W'},'Location','best');
    fig_id = fig_id+1;
    title([strrep(rxns{i},'_','-'),' - Constrained']);
    xlabel('Reaction flux');
end