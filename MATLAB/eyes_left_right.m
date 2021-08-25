% ONLY CONSIDERS FIXATIONS AT END OF SHIFT WHEN HEAD IS STILL
function a = eyes_left_right(dataset)
eye_vec = 3:1;
   for c = 1:height(dataset)
       M = HeadToVideoRot([dataset(c,2),dataset(c,3),dataset(c,4)],dataset(c,8), [0,0,0]);
       eye_vec(1,1) = dataset(c,5);
       eye_vec(2,1) = dataset(c,6);
       eye_vec(3,1) = dataset(c,7);
       e = M*eye_vec;
       dataset(c,5) = e(1,1);
       dataset(c,6) = e(2,1);
       dataset(c,7) = e(3,1);
   end
   display(e);
   a  = dataset;
end