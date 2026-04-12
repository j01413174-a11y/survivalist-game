<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<title>SURVIVALIST</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@400;700;900&display=swap');
*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent;touch-action:none}
body{background:#000;overflow:hidden;font-family:'Share Tech Mono',monospace;color:#fff;user-select:none}
canvas{display:block}
#hud{position:fixed;inset:0;pointer-events:none}
#topbar{position:absolute;top:0;left:0;right:0;background:linear-gradient(to bottom,rgba(0,0,0,.92),transparent);padding:8px 12px 16px;display:flex;justify-content:space-between;align-items:flex-start;gap:8px}
#titlelabel{font-family:'Orbitron',monospace;font-weight:900;font-size:9px;letter-spacing:4px;color:#a8ff78;line-height:2}
#statsarea{display:flex;flex-direction:column;gap:3px;flex:1;max-width:260px}
.srow{display:flex;align-items:center;gap:5px}
.slbl{font-size:7px;letter-spacing:1px;opacity:.45;width:24px;text-align:right}
.sbwrap{flex:1;height:5px;background:rgba(255,255,255,.1);border-radius:3px;overflow:hidden}
.sbar{height:100%;border-radius:3px;transition:width .18s}
#hpb{background:linear-gradient(90deg,#f44,#f88)}
#hub{background:linear-gradient(90deg,#f90,#fc4)}
#stb{background:linear-gradient(90deg,#4af,#8df)}
#mpb{background:linear-gradient(90deg,#a4f,#c8f)}
.sval{font-size:8px;opacity:.65;width:22px}
#rhud{display:flex;flex-direction:column;align-items:flex-end;gap:1px}
#rdaynum{font-family:'Orbitron',monospace;font-size:11px;color:#ffe88a}
#rclk{font-size:8px;color:#ffe88a;opacity:.55}
#rmaplbl{font-size:7px;color:#88ccff;letter-spacing:1px;max-width:100px;text-align:right}
#rweplbl{font-size:7px;color:#ffcc44;letter-spacing:1px;max-width:100px;text-align:right}
#rwavlbl{font-size:7px;color:#ff8844;letter-spacing:1px}
#rxpwrap{width:85px;height:3px;background:rgba(255,255,255,.1);border-radius:2px;overflow:hidden;margin-top:2px}
#rxpfill{height:100%;background:linear-gradient(90deg,#ffe800,#fa0);transition:width .3s}
#logarea{position:absolute;top:70px;left:10px;display:flex;flex-direction:column;gap:2px;pointer-events:none}
.le{font-size:8px;background:rgba(0,0,0,.76);padding:2px 7px;border-radius:3px;border-left:2px solid #a8ff78;animation:fl .16s ease;max-width:205px;line-height:1.4}
@keyframes fl{from{opacity:0;transform:translateX(-4px)}to{opacity:1}}
#mmbox{position:absolute;top:66px;right:10px;border:1px solid rgba(255,255,255,.12);border-radius:4px;overflow:hidden}
#mmcv{width:86px;height:86px;display:block}
#invpanel{position:absolute;left:10px;bottom:208px;background:rgba(0,0,0,.85);border:1px solid rgba(255,255,255,.08);border-radius:7px;padding:7px 9px;min-width:110px;max-width:126px;max-height:190px;overflow-y:auto}
#invtitle{font-size:7px;letter-spacing:2px;opacity:.35;margin-bottom:4px;text-align:center}
.irow{display:flex;justify-content:space-between;align-items:center;gap:5px;font-size:8px;padding:1px 0;cursor:pointer}
.iico{font-size:11px}.inm{opacity:.55;flex:1;font-size:7px;white-space:nowrap;overflow:hidden}.iqt{color:#a8ff78;font-size:9px;min-width:14px;text-align:right}
#eqpanel{position:absolute;left:10px;bottom:208px;background:rgba(0,0,0,.88);border:1px solid rgba(255,200,80,.2);border-radius:7px;padding:7px 9px;min-width:108px;display:none}
#eqpanel.open{display:block}
#eqtitle{font-size:7px;color:#ffe88a;opacity:.5;margin-bottom:4px;text-align:center;letter-spacing:2px}
.eqrow{display:flex;align-items:center;gap:5px;padding:2px 3px;border-radius:3px;border:1px solid rgba(255,255,255,.06);margin-bottom:2px;font-size:8px;cursor:pointer}
.eqrow:active{background:rgba(255,200,80,.1)}
.eqico{font-size:12px}.eqnm{flex:1;font-size:7px;opacity:.5}
#craftpanel{position:absolute;right:10px;bottom:208px;background:rgba(0,0,0,.94);border:1px solid rgba(255,255,255,.08);border-radius:7px;padding:10px;width:185px;max-height:275px;display:none;flex-direction:column;gap:3px}
#craftpanel.open{display:flex}
#crafttitle{font-size:7px;letter-spacing:2px;opacity:.35;text-align:center;margin-bottom:2px}
#catrow{display:flex;flex-wrap:wrap;gap:2px;margin-bottom:3px}
.catbtn{font-size:5px;letter-spacing:.7px;padding:2px 4px;border-radius:3px;border:1px solid rgba(255,255,255,.1);cursor:pointer;background:rgba(255,255,255,.03);pointer-events:all;white-space:nowrap}
.catbtn.sel{background:rgba(168,255,120,.14);border-color:rgba(168,255,120,.4);color:#a8ff78}
#rlist{overflow-y:auto;flex:1;display:flex;flex-direction:column;gap:3px;pointer-events:all}
.rcard{padding:5px 6px;border-radius:4px;border:1px solid rgba(255,255,255,.07);cursor:pointer}
.rcard:active{background:rgba(168,255,120,.08);border-color:#a8ff78}
.rcard.dis{opacity:.22;pointer-events:none}
.rcname{font-size:9px;color:#a8ff78}
.rccost{font-size:6px;opacity:.4;margin-top:1px;line-height:1.5}
.rcreq{font-size:6px;color:#ffcc44}
#spellbar{position:absolute;bottom:208px;left:50%;transform:translateX(-50%);display:none;gap:4px;background:rgba(0,0,0,.8);border:1px solid rgba(160,80,255,.25);border-radius:7px;padding:5px;pointer-events:all}
#spellbar.show{display:flex}
.spsl{width:38px;height:38px;border-radius:5px;background:rgba(160,80,255,.1);border:1px solid rgba(160,80,255,.3);display:flex;flex-direction:column;align-items:center;justify-content:center;font-size:14px;cursor:pointer;position:relative}
.spsl.ac{border-color:#cc66ff;background:rgba(160,80,255,.28);box-shadow:0 0 8px rgba(160,80,255,.4)}
.splbl{font-size:5px;opacity:.4}
#btmarea{position:fixed;bottom:0;left:0;right:0;height:203px;display:flex;align-items:center;justify-content:space-between;padding:0 12px 8px;pointer-events:none}
#hotbar{position:absolute;bottom:4px;left:50%;transform:translateX(-50%);display:flex;gap:4px;background:rgba(0,0,0,.82);border:1px solid rgba(255,255,255,.1);border-radius:7px;padding:5px;pointer-events:all}
.hsl{width:41px;height:41px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.14);border-radius:5px;display:flex;flex-direction:column;align-items:center;justify-content:center;cursor:pointer;position:relative;font-size:15px}
.hsl.ac{border-color:#a8ff78;background:rgba(168,255,120,.14);box-shadow:0 0 8px rgba(168,255,120,.2)}
.hsl.wt{border-color:rgba(255,150,50,.32)}.hsl.wt.ac{border-color:#ff9632}
.hsl.mt{border-color:rgba(160,80,255,.32)}.hsl.mt.ac{border-color:#cc66ff}
.hcnt{position:absolute;bottom:1px;right:3px;font-size:7px;opacity:.8}
.hkey{position:absolute;top:1px;left:3px;font-size:6px;opacity:.2}
#lszone{width:116px;height:116px;border-radius:50%;background:rgba(255,255,255,.03);border:1.5px solid rgba(255,255,255,.1);position:relative;flex-shrink:0;pointer-events:all}
#lsknob{width:42px;height:42px;border-radius:50%;background:rgba(168,255,120,.14);border:2px solid rgba(168,255,120,.38);position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);pointer-events:none}
#actbtns{display:grid;grid-template-columns:1fr 1fr;gap:6px;flex-shrink:0;pointer-events:all}
.abt{width:52px;height:52px;border-radius:50%;background:rgba(0,0,0,.62);border:1.5px solid rgba(255,255,255,.16);display:flex;flex-direction:column;align-items:center;justify-content:center;cursor:pointer;font-size:15px;gap:1px}
.abt:active,.abt.pr{background:rgba(168,255,120,.2);border-color:#a8ff78;transform:scale(.91)}
.abtl{font-size:5px;letter-spacing:.7px;opacity:.4;font-family:'Share Tech Mono',monospace}
#bspr{border-color:rgba(100,180,255,.25)}.#bspr.pr{background:rgba(100,180,255,.18);border-color:#88ddff}
#bcft{border-color:rgba(255,200,80,.25)}.#bcft.pr{background:rgba(255,200,80,.16);border-color:#ffcc44}
#bcas{border-color:rgba(160,80,255,.25)}.#bcas.pr{background:rgba(160,80,255,.18);border-color:#cc66ff}
#overlay{position:fixed;inset:0;background:#000;display:flex;flex-direction:column;align-items:center;justify-content:center;z-index:100;font-family:'Orbitron',monospace}
#overlay h1{font-size:clamp(24px,5vw,56px);font-weight:900;letter-spacing:10px;color:#a8ff78;margin-bottom:6px;animation:gw 3s ease-in-out infinite}
@keyframes gw{0%,100%{text-shadow:0 0 30px #a8ff7844}50%{text-shadow:0 0 60px #a8ff7888}}
.osub{font-size:8px;letter-spacing:3px;opacity:.35;margin-bottom:26px;font-family:'Share Tech Mono',monospace;text-align:center;line-height:2.2}
.mbtn{font-family:'Orbitron',monospace;font-size:10px;letter-spacing:3px;padding:12px 32px;background:transparent;border:1px solid #a8ff78;color:#a8ff78;cursor:pointer;border-radius:4px;margin:4px}
.mbtn:active{background:#a8ff78;color:#000}
#goscreen{position:fixed;inset:0;background:rgba(0,0,0,.95);display:none;flex-direction:column;align-items:center;justify-content:center;z-index:200;font-family:'Orbitron',monospace}
#goscreen.show{display:flex}
#goscreen h2{font-size:36px;color:#f44;letter-spacing:6px;margin-bottom:10px;text-shadow:0 0 40px #f4446688}
.gsub{font-size:8px;opacity:.45;letter-spacing:2px;margin-bottom:26px;font-family:'Share Tech Mono',monospace;max-width:300px;text-align:center;line-height:2}
#goscreen .mbtn{border-color:#f44;color:#f44}.#goscreen .mbtn:active{background:#f44;color:#000}
#wvbanner{position:fixed;top:42%;left:50%;transform:translate(-50%,-50%);font-family:'Orbitron',monospace;font-size:clamp(14px,3vw,28px);font-weight:900;color:#ff8844;letter-spacing:5px;pointer-events:none;text-align:center;opacity:0;transition:opacity .3s;z-index:60;text-shadow:0 0 30px #ff884488;white-space:nowrap}
#wvbanner.sh{opacity:1}
</style>
</head>
<body>
<canvas id="c"></canvas>
<div id="wvbanner"></div>
<div id="overlay">
  <h1>SURVIVALIST</h1>
  <div class="osub">300 WAVES · 20 MAPS · 25 WEAPONS · 8 SPELLS<br>58 RECIPES · BUILD · MAGIC · SURVIVE</div>
  <button class="mbtn" onclick="startGame()">BEGIN</button>
</div>
<div id="goscreen">
  <h2>YOU DIED</h2>
  <p class="gsub" id="drsn">Wave 1 · Day 1</p>
  <button class="mbtn" onclick="startGame()">TRY AGAIN</button>
</div>
<div id="hud">
  <div id="topbar">
    <div id="titlelabel">SURVIVALIST</div>
    <div id="statsarea">
      <div class="srow"><span class="slbl">HP</span><div class="sbwrap"><div class="sbar" id="hpb" style="width:100%"></div></div><span class="sval" id="hpv">100</span></div>
      <div class="srow"><span class="slbl">FOOD</span><div class="sbwrap"><div class="sbar" id="hub" style="width:100%"></div></div><span class="sval" id="huv">100</span></div>
      <div class="srow"><span class="slbl">STA</span><div class="sbwrap"><div class="sbar" id="stb" style="width:100%"></div></div><span class="sval" id="stv">100</span></div>
      <div class="srow"><span class="slbl">MP</span><div class="sbwrap"><div class="sbar" id="mpb" style="width:100%"></div></div><span class="sval" id="mpv">100</span></div>
    </div>
    <div id="rhud">
      <div id="rdaynum">DAY 1</div>
      <div id="rclk">12:00</div>
      <div id="rmaplbl">Verdant Forest</div>
      <div id="rweplbl">✊ Fists</div>
      <div id="rwavlbl">WAVE 0/300</div>
      <div id="rxpwrap"><div id="rxpfill" style="width:0%"></div></div>
    </div>
  </div>
  <div id="mmbox"><canvas id="mmcv"></canvas></div>
  <div id="invpanel"><div id="invtitle">INVENTORY</div><div id="invlist"></div></div>
  <div id="eqpanel"><div id="eqtitle">EQUIPPED</div><div id="eqlist"></div></div>
  <div id="craftpanel"><div id="crafttitle">CRAFTING</div><div id="catrow"></div><div id="rlist"></div></div>
  <div id="spellbar"></div>
  <div id="logarea"></div>
</div>
<div id="btmarea">
  <div id="lszone"><div id="lsknob"></div></div>
  <div id="hotbar"></div>
  <div id="actbtns">
    <button class="abt" id="bgat" ontouchstart="da('g',1);return false" ontouchend="da('g',0)" onmousedown="da('g',1)" onmouseup="da('g',0)">⛏️<span class="abtl">GATHER</span></button>
    <button class="abt" id="batk" ontouchstart="da('a',1);return false" ontouchend="da('a',0)" onmousedown="da('a',1)" onmouseup="da('a',0)">⚔️<span class="abtl">ATTACK</span></button>
    <button class="abt" id="beat" ontouchstart="da('e',1);return false" ontouchend="da('e',0)" onmousedown="da('e',1)" onmouseup="da('e',0)">🍖<span class="abtl">EAT</span></button>
    <button class="abt" id="bplc" ontouchstart="da('p',1);return false" ontouchend="da('p',0)" onmousedown="da('p',1)" onmouseup="da('p',0)">🏗️<span class="abtl">PLACE</span></button>
    <button class="abt" id="bspr" ontouchstart="spOn();return false" ontouchend="spOff()" onmousedown="spOn()" onmouseup="spOff()">💨<span class="abtl">SPRINT</span></button>
    <button class="abt" id="bcft" ontouchstart="togCraft();return false" onmousedown="togCraft()">🔨<span class="abtl">CRAFT</span></button>
    <button class="abt" id="bcas" ontouchstart="castSpell();return false" onmousedown="castSpell()">🔮<span class="abtl">CAST</span></button>
    <button class="abt" id="beqp" ontouchstart="togEq();return false" onmousedown="togEq()">🪖<span class="abtl">EQUIP</span></button>
  </div>
</div>
<script>
'use strict';
// WAKE LOCK
let wl=null;
async function rwl(){try{if('wakeLock'in navigator)wl=await navigator.wakeLock.request('screen');}catch(e){}}
document.addEventListener('visibilitychange',()=>{if(document.visibilityState==='visible')rwl();});

// CANVAS
const cv=document.getElementById('c'),ctx=cv.getContext('2d');
const mmcv=document.getElementById('mmcv'),mctx=mmcv.getContext('2d');
function rsz(){cv.width=innerWidth;cv.height=innerHeight;}rsz();
mmcv.width=86;mmcv.height=86;
window.addEventListener('resize',rsz);

// TILE IDs
const TG=0,TD=1,TS=2,TW=3,TSA=4,TSN=5,TLV=6,TSW=7,TAS=8,TCR=9,TDK=10,TRU=11,TIC=12,TMU=13;
const TW2=TW;
const TILECOLORS={
  0:['#2d5a1b','#355f20'],1:['#6b4c2a','#7a5530'],2:['#555566','#4a4a5a'],3:['#1a3d6e','#1e4577'],
  4:['#c2a06a','#cfab72'],5:['#d4eaf5','#deeef8'],6:['#cc4400','#dd5511'],7:['#2a4020','#344a28'],
  8:['#3a3a3a','#444'],9:['#334466','#445588'],10:['#0d0d1a','#12121f'],11:['#4a3f2f','#554535'],
  12:['#aaccdd','#bbddee'],13:['#2a2015','#352a1e']
};
const TW_SZ=32,WW=80,WH=80;

// 20 MAPS
const MAPS=[
  {id:0,n:'Verdant Forest',    s:1337, m:TG, f:TD,  r:TS,  w:TW,  wf:.13,rf:.09,tf:.14,sky:'#87ceeb',ef:['wolf','fox','goblin','bandit'],             ec:5, dr:{wood:.04,fiber:.02,herb:.015,berry:.012,flint:.008,stone:.018}},
  {id:1,n:'Deep Forest',       s:2674, m:TG, f:TD,  r:TS,  w:TW,  wf:.1, rf:.07,tf:.22,sky:'#1a3d10',ef:['wolf','spider','skeleton','goblin'],        ec:7, dr:{wood:.045,mushroom:.018,herb:.012,venom:.008,fiber:.016,bone:.01}},
  {id:2,n:'Sunlit Plains',     s:3011, m:TG, f:TD,  r:TS,  w:TW,  wf:.06,rf:.04,tf:.03,sky:'#6dbadf',ef:['fox','goblin','bandit','archer'],           ec:7, dr:{fiber:.03,herb:.02,berry:.018,flint:.012,feather:.012}},
  {id:3,n:'Sandy Desert',      s:4488, m:TSA,f:TSA, r:TS,  w:TW,  wf:.03,rf:.09,tf:.01,sky:'#f5d08a',ef:['bandit','bandit_chief','goblin','orc'],     ec:9, dr:{bone:.022,sulfur:.018,flint:.016,gem:.006,sand:.035,stone:.022}},
  {id:4,n:'Frozen Tundra',     s:5665, m:TSN,f:TIC, r:TS,  w:TIC, wf:.07,rf:.13,tf:.02,sky:'#b0d4e8',ef:['wolf','bear','skeleton','orc'],             ec:7, dr:{ice_crystal:.024,bone:.012,herb:.006,crystal:.007,wood:.014}},
  {id:5,n:'Misty Swamp',       s:6821, m:TSW,f:TMU, r:TS,  w:TW,  wf:.2, rf:.04,tf:.1, sky:'#4a5a3a',ef:['zombie','spider','wraith','goblin'],        ec:9, dr:{mushroom:.025,venom:.018,fiber:.016,silk:.01,herb:.01}},
  {id:6,n:'Mountain Pass',     s:7234, m:TS, f:TD,  r:TS,  w:TW,  wf:.04,rf:.28,tf:.02,sky:'#7a8898',ef:['troll','bear','orc','skeleton'],            ec:7, dr:{iron_ore:.022,crystal:.01,gem:.007,coal:.016,stone:.035}},
  {id:7,n:'Goblin Territory',  s:8456, m:TD, f:TD,  r:TS,  w:TW,  wf:.06,rf:.1, tf:.08,sky:'#7a9a6a',ef:['goblin','goblin_chief','bandit','orc'],     ec:12,dr:{bone:.018,feather:.015,leather:.012,flint:.012,wood:.018}},
  {id:8,n:'Coastal Shore',     s:9732, m:TSA,f:TSA, r:TS,  w:TW,  wf:.3, rf:.03,tf:.02,sky:'#4a9ad4',ef:['bandit','skeleton','goblin','archer'],      ec:8, dr:{fish:.025,silk:.012,sand:.04,feather:.018,bone:.01}},
  {id:9,n:'Ancient Ruins',     s:10551,m:TRU,f:TS,  r:TS,  w:TW,  wf:.03,rf:.22,tf:.01,sky:'#5a5060',ef:['skeleton','golem','dark_mage','wraith'],    ec:8, dr:{crystal:.018,magic_essence:.012,bone:.025,gem:.015,stone:.025}},
  {id:10,n:'Scorched Waste',   s:11889,m:TAS,f:TAS, r:TS,  w:TLV, wf:.07,rf:.12,tf:0,  sky:'#8a4020',ef:['troll','orc','orc_chief','dark_mage'],     ec:10,dr:{sulfur:.025,coal:.03,iron_ore:.016,ash_crystal:.007}},
  {id:11,n:'Volcanic Fields',  s:12004,m:TAS,f:TLV, r:TS,  w:TLV, wf:.16,rf:.08,tf:0,  sky:'#cc4400',ef:['troll','orc','golem','wraith'],             ec:9, dr:{sulfur:.03,coal:.035,iron_ore:.025,crystal:.007,gem:.004}},
  {id:12,n:'Orc Stronghold',   s:13377,m:TD, f:TMU, r:TS,  w:TW,  wf:.04,rf:.1, tf:.05,sky:'#6a5040',ef:['orc','orc_chief','troll','goblin_chief'],  ec:11,dr:{bone:.025,leather:.018,iron_ore:.016,coal:.012,wood:.016}},
  {id:13,n:'Bandit Outpost',   s:14220,m:TD, f:TS,  r:TS,  w:TW,  wf:.04,rf:.15,tf:.05,sky:'#5a5060',ef:['bandit','bandit_chief','archer','dark_mage'],ec:13,dr:{iron_ore:.016,leather:.016,gem:.007,flint:.016,coal:.01}},
  {id:14,n:'Crystal Cavern',   s:15641,m:TCR,f:TS,  r:TCR, w:TW,  wf:.04,rf:.22,tf:0,  sky:'#1a1a44',ef:['wraith','dark_mage','skeleton','golem'],   ec:9, dr:{crystal:.04,magic_essence:.022,gem:.018,ice_crystal:.016}},
  {id:15,n:'Haunted Graveyard',s:16007,m:TDK,f:TS,  r:TS,  w:TW,  wf:.04,rf:.09,tf:.04,sky:'#1a1a22',ef:['skeleton','zombie','wraith','dark_mage'],  ec:13,dr:{bone:.04,crystal:.012,magic_essence:.009,herb:.004,silk:.007}},
  {id:16,n:'Undead Kingdom',   s:17890,m:TDK,f:TS,  r:TS,  w:TDK, wf:.06,rf:.12,tf:0,  sky:'#0a0a1a',ef:['zombie','skeleton','wraith','dark_mage','golem'],ec:15,dr:{bone:.045,magic_essence:.018,crystal:.012,silk:.01}},
  {id:17,n:'Enchanted Grove',  s:18234,m:TG, f:TG,  r:TCR, w:TW,  wf:.1, rf:.05,tf:.16,sky:'#2a1a4a',ef:['dark_mage','wraith','goblin','spider'],    ec:9, dr:{magic_essence:.028,crystal:.018,herb:.03,silk:.018,mushroom:.012}},
  {id:18,n:"Dragon's Domain",  s:19555,m:TAS,f:TLV, r:TS,  w:TLV, wf:.12,rf:.1, tf:0,  sky:'#440000',ef:['dragon','troll','orc_chief','dark_mage'],  ec:5, dr:{gem:.025,crystal:.018,magic_essence:.018,sulfur:.025,bone:.018}},
  {id:19,n:'Corrupted Lands',  s:20001,m:TDK,f:TMU, r:TS,  w:TLV, wf:.1, rf:.1, tf:.02,sky:'#080810',ef:['dragon','dark_mage','wraith','orc_chief','bandit_chief'],ec:16,dr:{magic_essence:.03,crystal:.025,sulfur:.018,bone:.03,gem:.012}},
];

// WEAPONS (25)
const WEAPONS=[
  {id:'fists',          n:'Fists',            ico:'✊',dmg:5,  spd:20,rng:44, type:'melee',  mp:0,  fx:null},
  {id:'stick',          n:'Stick',            ico:'🥢',dmg:9,  spd:22,rng:48, type:'melee',  mp:0,  fx:null},
  {id:'stone_axe',      n:'Stone Axe',        ico:'🪓',dmg:15, spd:28,rng:44, type:'melee',  mp:0,  fx:null},
  {id:'flint_knife',    n:'Flint Knife',       ico:'🗡️',dmg:12, spd:14,rng:38, type:'melee',  mp:0,  fx:null},
  {id:'spear',          n:'Wooden Spear',      ico:'🔱',dmg:18, spd:30,rng:68, type:'melee',  mp:0,  fx:null},
  {id:'iron_sword',     n:'Iron Sword',        ico:'⚔️',dmg:28, spd:24,rng:50, type:'melee',  mp:0,  fx:null},
  {id:'iron_axe',       n:'Iron Axe',          ico:'🪓',dmg:35, spd:32,rng:46, type:'melee',  mp:0,  fx:null},
  {id:'iron_spear',     n:'Iron Spear',        ico:'🔱',dmg:26, spd:28,rng:72, type:'melee',  mp:0,  fx:null},
  {id:'steel_sword',    n:'Steel Sword',       ico:'🗡️',dmg:44, spd:22,rng:52, type:'melee',  mp:0,  fx:null},
  {id:'warhammer',      n:'Warhammer',         ico:'🔨',dmg:58, spd:48,rng:46, type:'melee',  mp:0,  fx:'stun'},
  {id:'flail',          n:'Flail',             ico:'⛓️',dmg:40, spd:28,rng:62, type:'melee',  mp:0,  fx:null},
  {id:'shortbow',       n:'Shortbow',          ico:'🏹',dmg:20, spd:30,rng:200,type:'ranged', mp:0,  fx:null},
  {id:'longbow',        n:'Longbow',           ico:'🏹',dmg:32, spd:38,rng:290,type:'ranged', mp:0,  fx:null},
  {id:'crossbow',       n:'Crossbow',          ico