%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
%�����������ڵ��˵�˵����ȷ��                                                       
clc;                                                                                
clear all;                                                                          
close all;                                                                          
MFCC_size=12;%mfcc��ά��                                                            
GMMM_component=16;%GMM component ����                                                                                                                      
mu_model=zeros(MFCC_size,GMMM_component);%��˹ģ�� ���� ��ֵ                        
sigma_model=zeros(MFCC_size,GMMM_component);%��˹ģ�� ���� ����                     
weight_model=zeros(GMMM_component);%��˹ģ�� ���� Ȩ��                              
file=['N';'F';'S'];                                                                                
train_file_path='E:\Desktop\��������Ƶ����\��Ƶ\3160102507-����-¼��\3160102507-W1\';%ģ��ѵ���ļ�·��                                 
num_train=6;%Ŀ��˵����ģ��ѵ���ļ��ĸ���                                           
test_file_path='E:\Desktop\��������Ƶ����\��Ƶ\3160102507-����-¼��\3160102507-W15\';%�����ļ�·��

num_test=2;%����������ʶ��Ĵ���                                                    
num_uttenance=18;%���������ÿ���ʶ��ľ��ӵ�����                                    
all_train_feature=[];                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                    
%train model                                                                        
%ʹ��1_1��1_6ѵ��                                                                   
for i=1:num_train                                                                   
    train_file=[train_file_path 'N' num2str(i) '.wav'];    
    [wav_data ,fs]=audioread(train_file);                                             
    train_feature=melcepst(wav_data ,fs);                                           
    all_train_feature=[all_train_feature;train_feature];                            
end                                                                                 
[mu_model,sigma_model,weight_model]=gmm_estimate(all_train_feature',GMMM_component);
                                                                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                    
%test                                                                               
                                                                   
for i=1:3     
    for j=1:6
        test_file=[test_file_path file(i) num2str(j) '.wav'];                
        [wav_data ,fs]=audioread(test_file);                                          
        test_feature=melcepst(wav_data ,fs);                                        
        [lYM, lY] = lmultigauss(test_feature', mu_model, sigma_model, weight_model);
        score((i-1)*6+j) = mean(lY);                                                        
        fprintf('Test��%s_%d  score:%f\n',file(i),j,score((i-1)*6+j)); 
    end
end                                                                             
                                                                             
                                                                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                      
%result                                                                             
[max_score,max_id]=max(score);                                                      
[min_score,min_id]=min(score);                                                      
fprintf('Max score:%f\nMin score:%f\n',max_score,min_score);
fprintf('Max-id:%d\nMin-id:%d\n',max_id,min_id);