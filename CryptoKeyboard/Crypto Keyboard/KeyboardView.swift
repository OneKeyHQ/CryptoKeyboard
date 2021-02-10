//
//  ContentView.swift
//  Shared
//
//  Created by bixin on 2021/2/3.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var viewModel: CKViewModel
    
    var body: some View {
        VStack {
            KeyboardHeader()
            ItemList()
                .cornerRadius(13)
            if viewModel.showInputModeSwitchKey {
                HStack {
                    Button(action: {
                        viewModel.switchInputMode()
                    }, label: {
                        Image("switch_lang")
                            .resizable()
                            .frame(width: 27, height: 27, alignment: .leading)
                    })
                    Spacer()
                }
            }
        }
        .padding(EdgeInsets(top: 15, leading: 12, bottom: 5, trailing: 12))
        .background(Color.clear)
    }
}

struct KeyboardHeader: View {
    @EnvironmentObject var viewModel: CKViewModel

    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                Image("app_icon_without_bg")
                    .resizable()
                    .frame(width: 34, height: 34, alignment: .center)
                Text("Crypto Keyboard\n在本地安全管理你的剪贴板")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color("text1"))
                    .lineSpacing(2)
                Spacer()
                Button(action: {
                    viewModel.delete()
                }, label: {
                    Image("delete")
                        .resizable()
                        .frame(width: 61, height: 34, alignment: .center)
                })
            }
            
            Button(action: {
                withAnimation {
                    simpleSuccess()
                    self.showDetail.toggle()
                }
            }, label: {
                HStack (alignment: .top) {
                    Text("每当唤醒 Crypto Keybaord，它会自动清空系统剪贴板中的所有 数据，并将其存储至系统安全区，以防其他恶意应用窃取。至多 在本地存储10条，超出部分自动删除。")
                        .lineLimit(showDetail ? 5 : 1)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 10, weight: .medium))
                        Image("chevron_right")
                            .resizable()
                            .frame(width: 5, height: 8)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                            .rotationEffect(.degrees(showDetail ? 90 : 0))

                }
                .foregroundColor(Color.text2)
                .lineSpacing(2.5)
            })
            .padding(EdgeInsets(.init(top: 6, leading: 0, bottom: 5, trailing: 0)))

        }
    }
}

struct ItemList: View {
    @EnvironmentObject var viewModel: CKViewModel
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("bg"))
    }
    
    var body: some View {
        ZStack {
            if viewModel.items.count != 0 {
                List {
                    ForEach(viewModel.items) { item in
                        Button (action: {
                            simpleSuccess()
                            viewModel.paste(content: item.content)
                        }, label: {
                            CKItemRow(item: item)
                                .frame(height: 38.5, alignment: .center)
                        })
                    }
                    .onDelete(perform: { indexSet in
                        simpleSuccess()
                        indexSet.forEach { index in
                            viewModel.remove(At: index)
                        }
                    })
                    .listRowBackground(Color("bg"))
                }
            } else {
                CKEmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color("bg"))
    }
}

struct CKEmptyView: View {
    var body: some View {
        VStack {
            Image("empty_inbox")
                .resizable()
                .frame(width: 27.3, height: 19.8, alignment: .center)
            
            Text("剪贴板无内容，\n复制后内容会出现在这里，\n同时系统剪贴板会被自动清空。")
                .font(.system(size: 12, weight: .regular))
                .lineSpacing(2.4)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(.init(top: 16, leading: 0, bottom: 0, trailing: 0)))

        }
    }
}

struct CKItemRow: View {
    var item: CKPasteboardItem

    var body: some View {
        HStack {
            Text(item.type.rawValue)
                .font(.system(size: 12))
                .foregroundColor(CKItemRow.colorFor(type: item.type))
                .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(CKItemRow.colorFor(type: item.type), lineWidth: 1)
                )
            
            Text(item.content)
                .lineLimit(1)
                .font(.custom("Menlo-Regular", size: 16))
                .truncationMode(.middle)
            
            Spacer()
            
            Text("粘贴")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.green1)
        }
        .foregroundColor(Color("text2"))
    }
    
    private static func colorFor(type: CKPasteboardItemType) -> Color {
        var color : Color
        switch type {
            case .privateKey: color = Color.privateKey
            case .address: color = Color.address
            case .normal: color = Color("text2")
        }
        return color;
    }
    
}

func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}
