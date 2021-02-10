//
//  Home.swift
//  CryptoKeyboard
//
//  Created by liuzhijie on 2021/2/3.
//

import SwiftUI

struct Home: View {
    let instructions = ["1. 前往 Crypto Keybaord 设置", "2. 点击键盘 ⌨️", "3. 允许完全访问"]
    let onekeyGithubUrl = URL(string: "https://github.com/OneKeyHQ")
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("bg"))
    }
    
    var body: some View {
        VStack {
            Image("appicon_with_bg_white")
                .resizable()
                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))

            Text("Crypto Keyboard")
                .font(.system(size: 30, weight: .semibold))
                .padding(.bottom, 12)

            
            Text("在本地安全管理你的剪贴板")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.text1)
                .padding(.bottom, 47)

            
            Text("3 步完成设置")
                .font(.system(size: 18, weight: .medium))
                .padding(.bottom, 23)

            List(0 ..< instructions.count) { item in
                HStack {
                    Text(instructions[item])
                        .font(.system(size: 17, weight: .regular))
                    if item == 0 {
                        Spacer()
                        Button(action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }, label: {
                            Image("green_right_arrow")
                                .resizable()
                                .frame(width: 23, height: 23, alignment: .center)
                        })
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .frame(maxWidth: .infinity, maxHeight: 147)
            .cornerRadius(13)
            .padding(.bottom, 12)

            Text("Crypto Keyboard 需要完全访问权限来清除剪贴板中的敏感信息，以保护你的数据安全。\n\n所有数据皆存储在本地 Keycahin，不会也不可能通过任何方式上传至服务器。App 代码完全开源，访问 \n")
                .foregroundColor(Color.text1)
            
            Button(action: {
                UIApplication.shared.open(onekeyGithubUrl!)
                
            }, label: {
                HStack {
                    Text(" https://github.com/OneKeyHQ")
                        .foregroundColor(Color.green1)
                    Image("link")
                        .resizable()
                        .frame(width: 9, height: 9, alignment: .center)
                    Text("了解详情。")
                        .foregroundColor(Color.text1)
                    
                    Spacer()

                }
            })
            
            Spacer()
            
            Image("onekey_logo_with_gray")
                .resizable()
                .frame(width: 46, height: 54, alignment: .center)
            
            Text("由 OneKey 团队呈现")
                .foregroundColor(Color("text4"))

        }
        .font(.system(size: 12, weight: .medium))
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 5, trailing: 16))
    }
}

struct HomeWrapper: View {
    var body: some View {
        ZStack {
            Color("HomeBackground").edgesIgnoringSafeArea(.all)
            Home()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeWrapper().preferredColorScheme(.dark).previewDevice("iPhone X")
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let text0 = Color.black
    static let text1 = Color("text1")
    static let text2 = Color(hex: 0x787980)
    static let text3 = Color(hex: 0x1a1a1a)

    static let normal = Color(hex: 0x1a1a1a)
    static let privateKey = Color(hex: 0xFF3B30)
    static let address = Color(hex: 0xF6C914)

    static let green1 = Color(hex: 0x1FBF2F)
}
