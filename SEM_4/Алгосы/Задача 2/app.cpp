#include <bits/stdc++.h>
using namespace std;
bool differentCases(char a,char b){
  return toupper(a)==toupper(b)&&a!=b;
}
int main(){
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  stack<char> s;
  stack<int> animals;
  stack<int> traps;
  map<int,int> animalIndexes;
  int animalCount=0,trapCount=0;
  char c;
  while(cin.get(c)){
    if(c=='\n')break;
    if(isupper(c)){
      trapCount++;
      traps.push(trapCount);
    }else{
      animalCount++;
      animals.push(animalCount);
    }
    if(s.empty()||!differentCases(c,s.top())){
      s.push(c);
    }else{
      animalIndexes[traps.top()]=animals.top();
      animals.pop();
      traps.pop();
      s.pop();
    }
  }
  if(!s.empty()){
    cout<<"Impossible\n";
    return 0;
  }
  cout<<"Possible\n";
  for(auto &p:animalIndexes){
    cout<<p.second<<" ";
  }
  return 0;
}
