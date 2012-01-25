function MT_analysis(P_mtw,P_pdw,P_t1w)

% $Id: MT_analysis.m 265 2011-08-01 10:58:48Z nikolaus $

if nargin==0,
    P_mtw = spm_select(Inf,'nifti','MT-weighted');
    P_pdw = spm_select(Inf,'nifti','PD-weighted');
    P_t1w = spm_select(Inf,'nifti','T1-weighted');
    P_trans = spm_select([0 2],'nifti','B1 map: T1w+map');
    P_receiv = spm_select([0 2],'nifti','Sensitivity map: T1w+map');
end

p = hinfo(P_mtw);
TE_mtw = cat(1,p.te);
TR_mtw = p(1).tr;
fa_mtw = p(1).fa;

p = hinfo(P_pdw);
TE_pdw = cat(1,p.te);
TR_pdw = p(1).tr;
fa_pdw = p(1).fa;

p = hinfo(P_t1w);
TE_t1w = cat(1,p.te);
TR_t1w = p(1).tr;
fa_t1w = p(1).fa;

MTProt(P_mtw, P_pdw, P_t1w, TE_mtw, TE_pdw, TE_t1w, TR_mtw, TR_pdw, TR_t1w, fa_mtw, fa_pdw, fa_t1w, P_trans, P_receiv);

function p = hinfo(P)
N = nifti(P);
for ii = 1:numel(N),
    tmp = regexp(N(ii).descrip,...
                 'TR=(?<tr>.+)ms/TE=(?<te>.+)ms/FA=(?<fa>.+)deg',...
                 'names');
    p(ii).tr=str2num(tmp.tr);
    p(ii).te=str2num(tmp.te);
    p(ii).fa=str2num(tmp.fa);
end

